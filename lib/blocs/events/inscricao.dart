import 'package:flutter/foundation.dart';
// Foreign
import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/turma.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/inscricao.dart';

abstract class InscricaoEvent extends Equatable {
  InscricaoEvent([List props = const []]) : super(props);
}

class InscricaoLoad extends InscricaoEvent {
  final TurmaModel turma;
  final AtividadeModel atividade;

  InscricaoLoad({
    @required this.turma,
    @required this.atividade
  }) : super([turma, atividade]);
  
  @override
  String toString() => 'InscricaoLoad';
}

class InscricaoRefresh extends InscricaoEvent{
  final List<InscricaoModel> inscricoes;
  final TurmaModel turma;
  final AtividadeModel atividade;

  InscricaoRefresh(
    this.inscricoes,
    this.turma,
    this.atividade
  ) : super([inscricoes, atividade, turma]);
  
  @override
  String toString() => 'InscricaoRefresh';
}

class InscricaoApply extends InscricaoEvent {
  final InscricaoModel chosenInscricao;

  InscricaoApply({this.chosenInscricao}) : super([chosenInscricao]);
  
  @override
  String toString() => 'InscricaoApply';
}