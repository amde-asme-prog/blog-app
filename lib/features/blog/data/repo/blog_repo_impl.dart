import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/error/server_exceptions.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/data/sources/local/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/sources/remote/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      //*********** GET ALL LOCALLY STORED BLOGS **************
      if (!await (connectionChecker.isConnected)) {
        return right(blogLocalDataSource.getAllLocalBlogs());
      }

      //*********** GET ALL BLOGS FROM REMOTE **************
      final blogs = await blogRemoteDataSource.getAllBlogs();

      //*********** UPLOAD LOCALLY **************
      blogLocalDataSource.uploadBlogsLocally(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
    required File image,
  }) async {
    try {
      //*********** CHECK INTERNET CONNECTION **************
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet connection"));
      }
      //*********** CREATE BLOG **************
      final blogModel = BlogModel(
        id: Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
        imagePath: '',
        updatedAt: DateTime.now(),
      );

      //*********** UPLOAD IMAGE **************
      final imagePath = await blogRemoteDataSource.uploadImage(
        image: image,
        id: blogModel.id,
      );

      //*********** UPDATE IMAGE PATH **************
      final updatedBlog = blogModel.copyWith(imagePath: imagePath);

      //*********** UPLOAD BLOG **************
      debugPrint(updatedBlog.toJson().toString());
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(updatedBlog);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
