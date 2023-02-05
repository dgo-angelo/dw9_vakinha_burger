import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burger/app/pages/auth/register/register_state.dart';
import 'package:vakinha_burger/app/repositories/auth/auth_repository.dart';

class RegisterContoller extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterContoller({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.register(name, email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
