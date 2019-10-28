import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/inscricao.dart';
import 'package:joparpet_app/models/presenca.dart';
import 'package:joparpet_app/models/api_response.dart';

abstract class PresencaState extends Equatable {
  final PresencaModel presenca;
  final InscricaoModel inscricao;

  PresencaState(
    this.presenca,
    this.inscricao,
    [List props = const []]
  ) : super([presenca, inscricao]..addAll(props));
}

class PresencaEmpty extends PresencaState {
  PresencaEmpty() : super(null, null);

  @override
  String toString() => 'PresencaEmpty';
}

class PresencaLoading extends PresencaState {
  PresencaLoading(
    InscricaoModel inscricao
  ) : super(null, inscricao);

  @override
  String toString() => 'PresencaLoading';
}

class PresencaSetSucessfull extends PresencaState {
  final PresencaModel presenca;
  final InscricaoModel inscricao;

  PresencaSetSucessfull(
    this.presenca,
    this.inscricao
  ) : super(presenca, inscricao);

  @override
  String toString() => 'PresencaSetSucessfull';
}

class PresencaSetFailed extends PresencaState {
  final APIError error;

  PresencaSetFailed(
    PresencaModel presenca,
    InscricaoModel inscricao, {this.error}
  ) : super(presenca, inscricao, [error]);

  @override
  String toString() => 'PresencaSetFailed';
}
