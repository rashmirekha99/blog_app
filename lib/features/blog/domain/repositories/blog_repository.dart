import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, Blog>> updateBlog({
    required File? image,
    required String id,
    required DateTime updatedAt,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required String imageUrl,

     
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
