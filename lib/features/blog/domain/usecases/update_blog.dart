import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBlog implements UseCase<Blog, UpdateBlogParams> {
  final BlogRepository blogRepository;

  UpdateBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UpdateBlogParams params) async {
    return await blogRepository.updateBlog(
        image: params.image,
        id: params.id,
        updatedAt: params.updatedAt,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics,
        imageUrl: params.imageUrl);
  }
}

class UpdateBlogParams {
  File? image;
  final String id;
  final DateTime updatedAt;
  final String title;
  final String content;
  final String posterId;
  final String imageUrl;
  final List<String> topics;

  UpdateBlogParams({
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
