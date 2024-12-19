import 'package:dio/dio.dart';
import 'package:pet/core/error/exceptions.dart';
import 'package:pet/core/network/api_client.dart';
import 'package:pet/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> loginUser(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient client;

  LoginRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> loginUser(String email, String password) async {
    try {
      final response = await client.post('/login', {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}
