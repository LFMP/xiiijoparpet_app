import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/evento.dart';

abstract class AtividadeState extends Equatable {
  final List<AtividadeModel> atividades;
  final EventoModel evento;

  AtividadeState(
    this.atividades,
    this.evento,
    [List props = const []]
  ) : super([atividades, evento]..addAll(props));
}

class AtividadeEmpty extends AtividadeState {
  AtividadeEmpty() : super([], null);

  @override
  String toString() => 'AtividadeEmpty';
}

class AtividadeLoading extends AtividadeState {
  AtividadeLoading(
    EventoModel evento
  ) : super(null, evento);

  @override
  String toString() => 'AtividadeLoading';
}

class AtividadeLoaded extends AtividadeState {
  AtividadeLoaded(
    List<AtividadeModel> atividades,
    EventoModel evento
  ) : super(atividades, evento);

  @override
  String toString() => 'AtividadeLoaded';
}

class AtividadeLoadFailed extends AtividadeState {
  final APIError error;

  AtividadeLoadFailed(
    EventoModel evento, {this.error}
  ) : super([], evento, [error]);

  @override
  String toString() => 'AtividadeLoadFailed';
}
