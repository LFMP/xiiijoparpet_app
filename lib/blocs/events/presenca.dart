import 'package:flutter/foundation.dart';
// Foreign
import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/inscricao.dart';
import 'package:joparpet_app/models/turma.dart';

abstract class PresencaEvent extends Equatable {
  PresencaEvent([List props = const []]) : super(props);
}

class PresencaSet extends PresencaEvent {
  final InscricaoModel inscricao;
  final DiaModel dia;

  PresencaSet({  
    @required this.inscricao,
    @required this.dia,
  }) : super([inscricao, dia]);

  @override
  String toString() => 'PresencaSet';
}