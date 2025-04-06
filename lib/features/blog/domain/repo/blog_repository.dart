import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, List<Blog>>> getAllBlogs();
  // Future<Blog> getBlogById(String id);
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
    required File image,
  });
  // Future<void> updateBlog(Blog blog);
  // Future<void> deleteBlog(String id);
}
