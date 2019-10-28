import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:joparpet_app/models/authorization.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthAppStarted extends AuthEvent {
  @override
  String toString() => 'AuthAppStarted';
}

class AuthLogin extends AuthEvent {
  final AuthRequest request;

  AuthLogin({@required this.request}) : super([request]);

  @override
  String toString() => 'AuthLogin { user: ${request.username} }';
}

class AuthLogout extends AuthEvent {
  @override
  String toString() => 'AuthLogout';
}
