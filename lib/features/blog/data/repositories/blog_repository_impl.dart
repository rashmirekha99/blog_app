import 'dart:io';

import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/blog/data/datasource/blog_data_source.dart';
import 'package:blog_app/features/blog/data/datasource/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogDataSource blogDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  BlogRepositoryImpl({
    required this.blogDataSource,
    required this.blogLocalDataSource,
    required this.internetConnectionChecker,
  });
//add new blog
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await internetConnectionChecker.getInternetConnection()) {
        return left(Failure(Constant.notHaveInternetConnectionMsg));
      } else {
        BlogModel blog = BlogModel(
            id: const Uuid().v1(),
            updatedAt: DateTime.now(),
            posterId: posterId,
            title: title,
            content: content,
            topics: topics,
            imageUrl: 'image_url');
        final uploadedImage =
            await blogDataSource.uploadBlogImage(image: image, blog: blog);
        blog = blog.copyWith(imageUrl: uploadedImage);
        final uploadedBlog = await blogDataSource.addBlog(blog);
        return right(uploadedBlog);
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await internetConnectionChecker.getInternetConnection()) {
        final localBlogs = blogLocalDataSource.readBlogsFromLocal();
        return right(localBlogs);
      } else {
        final blogs = await blogDataSource.getBlogs();
        blogLocalDataSource.saveBlogsInLocal(blog: blogs);
        return right(blogs);
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Blog>> updateBlog({
    required File? image,
    required String id,
    required DateTime updatedAt,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required String imageUrl,
  }) async {
    try {
      //no internet connection
      if (!await internetConnectionChecker.getInternetConnection()) {
        return left(Failure(Constant.notHaveInternetConnectionMsg));
      }
      //update content with image
      else if (image != null) {
        BlogModel blogData = BlogModel(
            id: id,
            updatedAt: updatedAt,
            posterId: posterId,
            title: title,
            content: content,
            topics: topics,
            imageUrl: imageUrl);
        final uploadedImage =
            await blogDataSource.updateBlogImage(image: image, blog: blogData);
        blogData = blogData.copyWith(imageUrl: uploadedImage);
        blogData = blogData.copyWith(updatedAt: DateTime.now());
        final uploadedBlog = await blogDataSource.updateBlog(blogData);
        return right(uploadedBlog);
      }
      //update content without image
      else {
        BlogModel blogData = BlogModel(
            id: id,
            updatedAt: updatedAt,
            posterId: posterId,
            title: title,
            content: content,
            topics: topics,
            imageUrl: imageUrl);
        blogData = blogData.copyWith(updatedAt: DateTime.now());
        final uploadedBlog = await blogDataSource.updateBlog(blogData);
        return right(uploadedBlog);
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
