part of 'blog_bloc.dart';


sealed class BlogEvent {}


class BlogAddEvent extends BlogEvent{
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;
  BlogAddEvent({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}
