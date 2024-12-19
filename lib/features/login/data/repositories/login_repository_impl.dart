import 'package:dartz/dartz.dart';
import 'package:pet/core/error/exceptions.dart';
import 'package:pet/core/error/failures.dart';
import 'package:pet/features/login/data/datasourses/login_remote_data_source.dart';
import 'package:pet/features/login/data/models/user_model.dart';
import 'package:pet/features/login/data/repositories/login_repository.dart';
import 'package:pet/features/login/domain/entites/user.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final UserModel userModel = await remoteDataSource.loginUser(
        email,
        password,
      );
      final User user = User(id: userModel.id, email: userModel.email);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
