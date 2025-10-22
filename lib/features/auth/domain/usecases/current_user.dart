import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  Future<Either<Failure, UserEntity>> call(NoParams params) async{
    return await authRepository.currentUser();
  }
}
