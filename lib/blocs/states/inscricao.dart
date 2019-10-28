import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/turma.dart';
import 'package:joparpet_app/models/inscricao.dart';

abstract class InscricaoState extends Equatable {
  final List<InscricaoModel> inscricoes;
  final TurmaModel turma;
  final AtividadeModel atividade;

  InscricaoState(
    this.inscricoes,
    this.turma,
    this.atividade,
    [List props = const []]
  ) : super([inscricoes, turma, atividade]..addAll(props));
}

class InscricaoEmpty extends InscricaoState {
  InscricaoEmpty() : super([], null, null);

  @override
  String toString() => 'InscricaoEmpty';
}

class InscricaoLoading extends InscricaoState {
  InscricaoLoading(
    TurmaModel turma,
    AtividadeModel atividade
  ) : super(null, turma, atividade);

  @override
  String toString() => 'InscricaoLoading';
}

class InscricaoLoaded extends InscricaoState {
  InscricaoLoaded(
    List<InscricaoModel> inscricoes,
    TurmaModel turma,
    AtividadeModel atividade
  ) : super(inscricoes, turma, atividade);

  @override
  String toString() => 'InscricaoLoaded';
}

class InscricaoLoadFailed extends InscricaoState {
  final APIError error;
  final TurmaModel turma;
  final AtividadeModel atividade;

  InscricaoLoadFailed(
    {this.turma, this.atividade, this.error}
  ) : super([], turma, atividade, [error]);

  @override
  String toString() => 'InscricaoLoadFailed';
}
