import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetBlog implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetBlog(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params)async {
  
   return await blogRepository.getAllBlogs();
  }
}


