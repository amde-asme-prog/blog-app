import 'dart:io';

import 'package:blog_app/core/error/server_exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<List<BlogModel>> getAllBlogs();

  // Future<BlogModel> getBlogById(String id);

  Future<BlogModel> uploadBlog(
    BlogModel blog,
  );

  Future<String> uploadImage({
    required File image,
    required String id,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  BlogRemoteDataSourceImpl(this.supabaseClient);
  final SupabaseClient supabaseClient;

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select("*, profiles(name)");

      return blogs
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name'] as String))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog(
    BlogModel blog,
  ) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required String id,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
