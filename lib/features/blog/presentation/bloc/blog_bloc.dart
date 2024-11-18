import 'dart:io';

import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/add_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/update_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final AddBlog _addBlog;
  final GetBlog _getBlog;
  final UpdateBlog _updateBlog;
  final DeleteBlog _deleteBlog;
  BlogBloc(
      {required AddBlog addBlog,
      required GetBlog getBlog,
      required UpdateBlog updateBlog,
      required DeleteBlog deleteBlog})
      : _addBlog = addBlog,
        _getBlog = getBlog,
        _updateBlog = updateBlog,
        _deleteBlog = deleteBlog,
        super(BlogInitial()) {
    //initial Loading
    on<BlogEvent>(
      (event, emit) => emit(BlogLoading()),
    );
    //add blog
    on<BlogAddEvent>((event, emit) async {
      final res = await _addBlog(AddBlogParams(
          title: event.title,
          content: event.content,
          posterId: event.posterId,
          topics: event.topics,
          image: event.image));

      res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(BlogSucess(r)));
    });
    //fetch all blogs
    on<BlogReadEvent>((event, emit) async {
      final res = await _getBlog(NoParams());
      res.fold(
          (l) => emit(BlogFailure(l.message)), (r) => emit(BlogListSucess(r)));
    });
    //update single blog
    on<BlogUpdateEvent>((event, emit) async {
      final res = await _updateBlog(UpdateBlogParams(
        id: event.id,
        updatedAt: event.updatedAt,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        imageUrl: event.imageUrl,
        topics: event.topics,
        image: event.image,
      ));
      res.fold((l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogUpdateSucess(message: Constant.updateSucesMessage)));
    });

    //delete single blog
    on<BlogDeleteEvent>((event, emit) async {
      final res = await _deleteBlog(DeleteBlogParams(blogId: event.blogId));
      res.fold((l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDeleteSucess(message: Constant.deleteSucesMessage)));
    });
  }
}
