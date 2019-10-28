import 'package:flutter/foundation.dart';
// Exports
export 'package:joparpet_app/blocs/events/evento.dart';
export 'package:joparpet_app/blocs/states/evento.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:joparpet_app/blocs/atividade.dart';
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/evento.dart';
// Repository
import 'package:joparpet_app/repositories/event_repository.dart';
// Models
import 'package:joparpet_app/models/evento.dart';
import 'package:joparpet_app/models/api_response.dart';

class EventoBloc extends Bloc<EventoEvent, EventoState>{

  final AuthBloc authBloc;
  final AtividadeBloc atividadeBloc;

  EventoBloc({
    @required this.authBloc,
    @required this.atividadeBloc
  });

  @override
  EventoState get initialState => EventoEmpty();

  List<EventoModel> get currentEvents => currentState.events;
  
  @override
  Stream<EventoState> mapEventToState(EventoEvent event) async* {

    if (event is EventoLoad) {
      yield EventoLoading();
      
      final events = await EventRepository.fetchEvents(authBloc.token);
      
      if (events.isSucessfull)
        yield EventoLoaded((events as ListEventoModel).events);
      else
        yield EventoLoadFailed(error: (events as APIError));
    }

    if (event is EventoRefresh){
      yield EventoLoading();
      yield EventoLoaded(currentEvents);
    }

    if (event is EventoApply){
      atividadeBloc.dispatch(AtividadeLoad(
        evento: event.chosenEvento
      ));
      yield EventoLoaded(currentEvents);
    }
    
  }
}