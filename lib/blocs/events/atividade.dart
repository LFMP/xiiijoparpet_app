import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/evento.dart';

abstract class AtividadeEvent extends Equatable {
  AtividadeEvent([List props = const []]) : super(props);
}

class AtividadeLoad extends AtividadeEvent {
  final EventoModel evento;
  AtividadeLoad({this.evento}) : super([evento]);
  
  @override
  String toString() => 'AtividadeLoad';
}

class AtividadeRefresh extends AtividadeEvent{
  final List<AtividadeModel> atividades;
  final EventoModel evento;

  AtividadeRefresh(
    this.atividades,
    this.evento
  ) : super([atividades, evento]);
  
  @override
  String toString() => 'AtividadeRefresh';
}

class AtividadeApply extends AtividadeEvent {
  final AtividadeModel chosenAtividade;

  AtividadeApply({this.chosenAtividade}) : super([chosenAtividade]);
  
  @override
  String toString() => 'AtividadeApply';
}