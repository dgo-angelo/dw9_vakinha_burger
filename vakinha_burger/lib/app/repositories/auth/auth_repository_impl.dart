import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burger/app/models/auth_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;
  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e, s) {
      log('Falha ao cadastrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Falha ao cadastrar usuário.');
    }
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await dio.unauth().post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthModel.fromMap(response.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Usuário ou senha inválidos', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
