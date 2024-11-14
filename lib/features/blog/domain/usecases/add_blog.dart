import 'dart:io';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class AddBlog implements UseCase<Blog, AddBlogParams> {
  final BlogRepository blogRepository;
  AddBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class AddBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;
  AddBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}
