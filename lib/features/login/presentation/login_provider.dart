import 'package:flutter/material.dart';
import 'package:pet/core/error/failures.dart';
import 'package:pet/features/login/domain/entites/user.dart';
import 'package:pet/features/login/domain/usercases/login.dart';

class LoginProvider extends ChangeNotifier {
  late final Login loginUseCase;
  bool _isLoading = false;
  User? _user;
  String? _errorMessage;

  LoginProvider({required this.loginUseCase});

  bool get isLoading => _isLoading;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final failureOrUser = await loginUseCase(email, password);

    _isLoading = false;
    notifyListeners();

    void handleFailure(Failure failure) {
      if (failure is ServerFailure) {
        _errorMessage = 'Server Failure';
      } else {
        _errorMessage = 'Unexpected error';
      }
    }

    void handleSuccess(User user) {
      _user = user;
      _errorMessage = null;
    }

    failureOrUser.fold(
      (failure) => handleFailure(failure),
      (user) => handleSuccess(user),
    );
  }
}
