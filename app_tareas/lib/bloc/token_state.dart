//Terminado
import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';

class TokenState extends Equatable {
  final String authToken;
  final String refreshToken;

  const TokenState({this.authToken = "", this.refreshToken = ""});

  //Map
  factory TokenState.fromMap(Map tokenMap) {
    return TokenState(
      authToken: tokenMap["response"]['authToken'],
      refreshToken: tokenMap["response"]['refreshToken'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [authToken, refreshToken];

  Widget when(
      {required Widget Function(TokenState) initial,
      required Widget Function(TokenState) authenticated,
      required Widget Function(TokenState) unauthenticated}) {
    throw UnimplementedError();
  }
}
