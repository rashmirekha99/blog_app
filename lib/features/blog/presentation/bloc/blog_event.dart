part of 'blog_bloc.dart';

sealed class BlogEvent {}

class BlogAddEvent extends BlogEvent {
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

class BlogReadEvent extends BlogEvent {}

class BlogUpdateEvent extends BlogEvent {
  File? image;
  final String id;
  final DateTime updatedAt;
  final String title;
  final String content;
  final String posterId;
  final String imageUrl;
  final List<String> topics;

  BlogUpdateEvent({
    required this.image,
    required this.id,
    required this.updatedAt,
    required this.title,
    required this.content,
    required this.posterId,
    required this.imageUrl,
    required this.topics,
  });
}
