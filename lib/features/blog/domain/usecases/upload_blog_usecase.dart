import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCaseWithParams<Blog, BlogParams> {
  UploadBlogUsecase(this.blogRepository);
  final BlogRepository blogRepository;

  @override
  Future<Either<Failure, Blog>> call(BlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
      image: params.image,
    );
  }
}

class BlogParams {
  BlogParams({
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
    required this.image,
  });

  final String title;
  final String content;
  final List<String> topics;
  final String posterId;
  final File image;
}
