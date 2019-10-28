import 'package:flutter/foundation.dart';
// Exports
export 'package:joparpet_app/blocs/events/atividade.dart';
export 'package:joparpet_app/blocs/states/atividade.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/events/atividade.dart';
import 'package:joparpet_app/blocs/states/atividade.dart';
import 'package:joparpet_app/blocs/turma.dart';
// Repository
import 'package:joparpet_app/repositories/atividade_repository.dart';
// Models
import 'package:joparpet_app/models/evento.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/api_response.dart';

class AtividadeBloc extends Bloc<AtividadeEvent, AtividadeState>{

  final AuthBloc authBloc;
  final TurmaBloc turmaBloc;

  AtividadeBloc({
    @required this.authBloc,
    @required this.turmaBloc
  });

  @override
  AtividadeState get initialState => AtividadeEmpty();

  List<AtividadeModel> get currentAtividades => currentState.atividades;
  EventoModel get currentEvento => currentState.evento;

  
  @override
  Stream<AtividadeState> mapEventToState(AtividadeEvent event) async* {

    if (event is AtividadeLoad) {
      final _currentEvent =  event.evento;
      yield AtividadeLoading(_currentEvent);
      
      final atividades = await AtividadeRepository.fetchEvents(
        _currentEvent.id,
        authBloc.token
      );
      
      if (atividades.isSucessfull)
        yield AtividadeLoaded(
          (atividades as ListAtividadeModel).atividades,
          _currentEvent
        );
      else
        yield AtividadeLoadFailed(
          _currentEvent,
          error: (atividades as APIError)
        );
    }

    if (event is AtividadeRefresh){
      yield AtividadeLoading(event.evento);
      yield AtividadeLoaded(event.atividades, event.evento);
    }

    if (event is AtividadeApply){
      turmaBloc.dispatch(TurmaLoad(
        atividade: event.chosenAtividade
      ));
      yield AtividadeLoaded(
        currentAtividades,
        currentEvento
      );
    }
  }
}