import 'package:dartz/dartz.dart';
import 'package:pet/core/error/failures.dart';
import 'package:pet/features/login/data/repositories/login_repository.dart';
import 'package:pet/features/login/domain/entites/user.dart';

class Login {
  final LoginRepository repository;
  Login(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
