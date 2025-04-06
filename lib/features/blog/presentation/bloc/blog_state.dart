part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogsLoaded extends BlogState {
  const BlogsLoaded({
    required this.blogs,
  });
  final List<Blog> blogs;
}

final class BlogError extends BlogState {
  const BlogError({
    required this.error,
  });
  final String error;
}

final class BlogSuccess extends BlogState {
  const BlogSuccess();
}
