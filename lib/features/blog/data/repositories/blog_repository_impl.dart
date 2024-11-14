import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/datasource/blog_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogDataSource blogDataSource;
  BlogRepositoryImpl(this.blogDataSource);
  
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blog = BlogModel(
          id: const Uuid().v1(),
          updatedAt: DateTime.now(),
          posterId: posterId,
          title: title,
          content: content,
          topics: topics,
          imageUrl: 'image_url');
      final uploadedImage=
      await blogDataSource.uploadBlogImage(image: image, blog: blog);
      blog.copyWith(imageUrl: uploadedImage);
     final uploadedBlog= await blogDataSource.addBlog(blog);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
