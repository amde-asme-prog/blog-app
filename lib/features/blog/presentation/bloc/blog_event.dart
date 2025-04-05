part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class GetAllBlogs extends BlogEvent {}

final class UploadBlog extends BlogEvent {
  UploadBlog({
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
