import 'package:dartz/dartz.dart';
import 'package:pet/core/error/failures.dart';
import 'package:pet/features/login/domain/entites/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
