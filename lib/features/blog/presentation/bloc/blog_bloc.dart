import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;
  BlogBloc(this.uploadBlog, this.getAllBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>((event, emit) async {
      final res = await uploadBlog(
        UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics,
        ),
      );
      res.fold(
        (l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogUploadSuccess()),
      );
    });
    on<BlogFetchAllBlogs>((event, emit) async {
      final res = await getAllBlogs(NoParams());
      res.fold(
        (l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogsDisplaySuccess(blogs: r)),
      );
    });
  }
}
