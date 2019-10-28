import 'dart:async';
// Exports
export 'package:joparpet_app/blocs/events/auth.dart';
export 'package:joparpet_app/blocs/states/auth.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:joparpet_app/blocs/events/auth.dart';
import 'package:joparpet_app/blocs/states/auth.dart';
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/authorization.dart';
import 'package:joparpet_app/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc();

  @override
  AuthState get initialState => AuthUninitialized();

  String get token => currentState is AuthAuthenticated
      ? (currentState as AuthAuthenticated).response.token
      : '';

  String get userId => currentState is AuthAuthenticated
      ? (currentState as AuthAuthenticated).response.userId
      : '';

  String get realm => currentState is AuthAuthenticated
      ? (currentState as AuthAuthenticated).response.realm
      : '';

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthAppStarted) {
      // TODO: Check if haas token saved
      yield AuthUninitialized();

      // await Future.delayed(Duration(seconds: 2));
      // final bool hasToken = await userRepository.hasToken();

      // if (hasToken) {
      //   yield AuthAuthenticated();
      // } else {
      //   yield AuthUnauthenticated();
      // }
    }

    if (event is AuthLogin) {
      yield AuthLoading();
      final r = await AuthRepository.login(event.request);
      if (r.isSucessfull)
        yield AuthAuthenticated(response: r as AuthResponse);
      else
        yield AuthUnauthenticated(error: r as APIError);
    }

    if (event is AuthLogout) {
      // yield AuthLoading();
      // await userRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
