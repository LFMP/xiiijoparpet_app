import 'package:equatable/equatable.dart';
// Models
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/models/evento.dart';

abstract class EventoState extends Equatable {
  final List<EventoModel> events;
  EventoState(
    this.events,
    [List props = const []]
  ) : super([events]..addAll(props));
}

class EventoEmpty extends EventoState {
  EventoEmpty() : super([]);

  @override
  String toString() => 'EventoEmpty';
}

class EventoLoading extends EventoState {
  EventoLoading() : super(null);

  @override
  String toString() => 'EventoLoading';
}

class EventoLoaded extends EventoState {
  EventoLoaded(
    List<EventoModel> events,
  ) : super(events);

  @override
  String toString() => 'EventoLoaded';
}

class EventoLoadFailed extends EventoState {
  final APIError error;

  EventoLoadFailed({this.error}) : super([], [error]);

  @override
  String toString() => 'EventoLoadFailed';
}
