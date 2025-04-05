import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  //*********** Dependencies **************
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  final UploadBlogUsecase _uploadBlogUsecase;

  //*********** Constructor **************
  BlogBloc({
    required GetAllBlogsUsecase getAllBlogsUsecase,
    required UploadBlogUsecase uploadBlogUsecase,
  })  : _getAllBlogsUsecase = getAllBlogsUsecase,
        _uploadBlogUsecase = uploadBlogUsecase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<GetAllBlogs>(_handleGetAllBlogs);

    on<UploadBlog>(_handleBlogUpload);
  }

  //*********** Get All Blogs **************
  Future<void> _handleGetAllBlogs(
      GetAllBlogs event, Emitter<BlogState> emit) async {
    try {
      final result = await _getAllBlogsUsecase(NoParams());
      result.fold(
        (failure) => emit(BlogError(error: failure.message)),
        (blogs) => emit(BlogsLoaded(blogs: blogs)),
      );
    } catch (e) {
      emit(BlogError(error: e.toString()));
    }
  }

  //*********** Upload Blog **************
  Future<void> _handleBlogUpload(
    UploadBlog event,
    Emitter<BlogState> emit,
  ) async {
    try {
      final result = await _uploadBlogUsecase(
        BlogParams(
          title: event.title,
          content: event.content,
          topics: event.topics,
          posterId: event.posterId,
          image: event.image,
        ),
      );

      result.fold(
        (failure) => emit(BlogError(error: failure.message)),
        (blog) => emit(BlogSuccess()),
      );
    } catch (e) {
      emit(BlogError(error: e.toString()));
    }
  }
}
