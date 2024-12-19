import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options.baseUrl = 'http://localhost:5000/api/users';
  }

  Future<Response> post(String url, Map<String, dynamic> body) async {
    Response response = await dio.post(url, data: body);
    return response;
  }
}
