import 'dart:io';

import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/add_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final AddBlog _addBlog;
  BlogBloc({
    required AddBlog addBlog,
  })  : _addBlog = addBlog,
        super(BlogInitial()) {
    on<BlogEvent>(
      (event, emit) => emit(BlogLoading()),
    );
    on<BlogAddEvent>((event, emit) async {
      print('########');
      print(event.title);
      print(event.content);
      print(event.posterId);
      print(event.topics);
      print(event.image);
      print('########');
      final res = await _addBlog(AddBlogParams(
          title: event.title,
          content: event.content,
          posterId: event.posterId,
          topics: event.topics,
          image: event.image));

      res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(BlogSucess(r)));
    });
  }
}
