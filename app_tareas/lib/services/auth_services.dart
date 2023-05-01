//Terminado
import 'dart:convert';

import 'package:app_tareas/bloc/login_state.dart';
import 'package:app_tareas/bloc/token_state.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class AuthServices {
  //Login
  static Future<TokenState> login(LoginUserState login) async {
    try {
      var url = Uri.parse(baseUrl + '/auth/login');
      final msg = jsonEncode({
        'username': login.user,
        'password': login.password,
      });
      http.Response response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: msg);
      print(response.body);
      //-------------------------
      if (response.statusCode == 200) {
        Map responseMap = json.decode(response.body);
        if (responseMap["code"] != "0000") {
          return const TokenState(
              authToken: "Error de autenticación",
              refreshToken: "Error de Autenticación");
        } else {
          TokenState token = TokenState.fromMap(responseMap);
          return token;
        }
      } else {
        return const TokenState(
            authToken: "error 404", refreshToken: "error 404");
      }
    } catch (e) {
      return const TokenState(
          authToken: "error 404", refreshToken: "error 404");
    }
  }
}
