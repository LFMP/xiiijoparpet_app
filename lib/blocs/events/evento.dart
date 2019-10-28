import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/evento.dart';

abstract class EventoEvent extends Equatable {
  EventoEvent([List props = const []]) : super(props);
}

class EventoLoad extends EventoEvent {
  EventoLoad() : super();
  
  @override
  String toString() => 'EventoLoad';
}

class EventoRefresh extends EventoEvent{
  final List<EventoModel> events;

  EventoRefresh(
    this.events
  ) : super([events]);
  
  @override
  String toString() => 'EventoRefresh';
}

class EventoApply extends EventoEvent {
  final EventoModel chosenEvento;

  EventoApply({this.chosenEvento}) : super([chosenEvento]);
  
  @override
  String toString() => 'EventoApply';
}