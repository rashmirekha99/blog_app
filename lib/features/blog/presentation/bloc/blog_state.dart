part of 'blog_bloc.dart';

sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogSucess extends BlogState {
  final Blog blog;
  BlogSucess(this.blog);
}

final class BlogUpdateSucess extends BlogState {
  final String message;

  BlogUpdateSucess({required this.message});

}

final class BlogListSucess extends BlogState {
  final List<Blog> blogs;
  BlogListSucess(this.blogs);
}

final class BlogFailure extends BlogState {
  final String messsage;
  BlogFailure(this.messsage);
}

final class BlogLoading extends BlogState {}
