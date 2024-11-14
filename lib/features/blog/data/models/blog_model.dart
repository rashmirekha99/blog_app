import 'package:blog_app/features/blog/domain/enities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.updatedAt,
    required super.posterId,
    required super.title,
    required super.content,
    required super.topics,
    required super.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'poster_id': posterId,
      'title': title,
      'content': content,
      'topics': topics,
      'image_url': imageUrl,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      updatedAt:map['updated_at']==null?DateTime.now(): DateTime.parse(map['updated_at']),
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      topics: List<String>.from(map['topics'] ??[]),
      imageUrl: map['image_url'] as String,
    );
  }
  //can update values through this
BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? posterId,
    String? title,
    String? content,
    List<String>? topics,
    String? imageUrl,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
  }
