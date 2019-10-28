import 'package:flutter/foundation.dart';
// Exports
export 'package:joparpet_app/blocs/events/inscricao.dart';
export 'package:joparpet_app/blocs/states/inscricao.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/events/inscricao.dart';
import 'package:joparpet_app/blocs/states/inscricao.dart';
import 'package:joparpet_app/blocs/presenca.dart';
// Repository
import 'package:joparpet_app/repositories/inscricao_repository.dart';
// Models
import 'package:joparpet_app/models/turma.dart';
import 'package:joparpet_app/models/atividade.dart';
import 'package:joparpet_app/models/inscricao.dart';
import 'package:joparpet_app/models/api_response.dart';

class InscricaoBloc extends Bloc<InscricaoEvent, InscricaoState>{

  final AuthBloc authBloc;
  final PresencaBloc presencaBloc;

  InscricaoBloc({
    @required this.authBloc,
    @required this.presencaBloc
  });

  @override
  InscricaoState get initialState => InscricaoEmpty();

  List<InscricaoModel> get currentInscricaos => currentState?.inscricoes ?? [];
  TurmaModel get currentTurma => currentState.turma;
  AtividadeModel get currentAtividade => currentState.atividade;

  
  @override
  Stream<InscricaoState> mapEventToState(InscricaoEvent event) async* {

    if (event is InscricaoLoad) {
      final _currentTurma =  event.turma;
      final _currentAtividade = event.atividade;

      yield InscricaoLoading(_currentTurma, _currentAtividade);
      
      final inscricoes = await InscricaoRepository.fetchEvents(
        atividadeId: _currentAtividade.id,
        turmaId: _currentTurma.id,
        token: authBloc.token
      );
      
      if (inscricoes.isSucessfull)
        yield InscricaoLoaded(
          (inscricoes as ListInscricaoModel).inscricoes,
          _currentTurma,
          _currentAtividade
        );
      else
        yield InscricaoLoadFailed(
          turma: _currentTurma,
          atividade: _currentAtividade,
          error: (inscricoes as APIError)
        );
    }

    if (event is InscricaoRefresh){
      yield InscricaoLoading(
        event.turma, event.atividade
      );
      yield InscricaoLoaded(
        event.inscricoes, event.turma, event.atividade
      );
    }

    if (event is InscricaoApply){
      presencaBloc.dispatch(PresencaSet(
        inscricao: event.chosenInscricao,
        dia: currentTurma.today
      ));
      yield InscricaoLoaded(
        currentInscricaos, currentTurma, currentAtividade
      );
    }
  }
}