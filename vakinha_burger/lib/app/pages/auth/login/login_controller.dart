import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burger/app/core/exceptions/unauthorized_exception.dart';
import 'package:vakinha_burger/app/pages/auth/login/login_state.dart';
import 'package:vakinha_burger/app/repositories/auth/auth_repository.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authModel.accessToken);
      sp.setString('refreshToken', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log('Usuário ou senha inválidos.', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            errorMessage: 'Usuário ou senha inválidos'),
      );
    } catch (e, s) {
      log('Falha ao efetuar login.', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.error, errorMessage: 'Falha ao efetuar login.'),
      );
    }
  }
}
