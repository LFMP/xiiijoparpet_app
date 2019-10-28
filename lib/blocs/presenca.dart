import 'package:flutter/foundation.dart';
// Exports
export 'package:joparpet_app/blocs/events/presenca.dart';
export 'package:joparpet_app/blocs/states/presenca.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/events/presenca.dart';
import 'package:joparpet_app/blocs/states/presenca.dart';
import 'package:joparpet_app/models/inscricao.dart';
// Repository
import 'package:joparpet_app/repositories/presenca_repository.dart';
// Models
import 'package:joparpet_app/models/presenca.dart';
import 'package:joparpet_app/models/api_response.dart';

class PresencaBloc extends Bloc<PresencaEvent, PresencaState>{

  final AuthBloc authBloc;

  PresencaBloc({@required this.authBloc});

  @override
  PresencaState get initialState => PresencaEmpty();

  PresencaModel get currentPresenca => currentState.presenca;
  InscricaoModel get currentInscricao => currentState.inscricao;

  
  @override
  Stream<PresencaState> mapEventToState(PresencaEvent event) async* {

    if (event is PresencaSet) {
      final _currentInscricao =  event.inscricao;
      yield PresencaLoading(_currentInscricao);

      final _currentDia = event.dia;

      final presenca = PresencaModel(
        inscricaoId: _currentInscricao.id,
        diaId: _currentDia?.id ?? -1,
        dataPresenca: DateTime.now(),
        responsavelPresencaId: authBloc.userId
      );

      final presencaResponse = await PresencaRepository.setPresenca(
        presenca,
        authBloc.token
      );
      
      if (presencaResponse.isSucessfull)
        yield PresencaSetSucessfull(
          presenca,
          _currentInscricao
        );
      else
        yield PresencaSetFailed(
          presenca,
          _currentInscricao,
          error: (presencaResponse as APIError),
        );
    }

  }
}