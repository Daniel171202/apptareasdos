//Terminado
import 'package:app_tareas/bloc/token_state.dart';
import 'package:bloc/bloc.dart';
import '../services/auth_services.dart';
import 'login_state.dart';
import 'package:flutter/material.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(const TokenState());
  //Login
  void login(LoginUserState login) async {
    TokenState token = await AuthServices.login(login);
    emit(token);
  }
}
