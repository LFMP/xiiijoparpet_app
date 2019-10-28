import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/turma.dart';

abstract class TurmaState extends Equatable {
  final List<TurmaModel> turmas;
  final AtividadeModel atividade;

  TurmaState(
    this.turmas,
    this.atividade,
    [List props = const []]
  ) : super([turmas, atividade]..addAll(props));
}

class TurmaEmpty extends TurmaState {
  TurmaEmpty() : super([], null);

  @override
  String toString() => 'TurmaEmpty';
}

class TurmaLoading extends TurmaState {
  TurmaLoading(
    AtividadeModel atividade
  ) : super(null, atividade);

  @override
  String toString() => 'TurmaLoading';
}

class TurmaLoaded extends TurmaState {
  TurmaLoaded(
    List<TurmaModel> turmas,
    AtividadeModel atividade
  ) : super(turmas, atividade);

  @override
  String toString() => 'TurmaLoaded';
}

class TurmaLoadFailed extends TurmaState {
  final APIError error;

  TurmaLoadFailed(
    AtividadeModel atividade, {this.error}
  ) : super([], atividade, [error]);

  @override
  String toString() => 'TurmaLoadFailed';
}
