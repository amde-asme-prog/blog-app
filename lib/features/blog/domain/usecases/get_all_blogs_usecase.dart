import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUsecase implements UseCaseWithParams<List<Blog>, NoParams> {
  GetAllBlogsUsecase(this.blogRepository);
  final BlogRepository blogRepository;

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
