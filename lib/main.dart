import 'package:flutter/material.dart';
// Pages
import 'package:joparpet_app/pages/login_page.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/evento.dart';
import 'package:joparpet_app/blocs/atividade.dart';
import 'package:joparpet_app/blocs/turma.dart';
import 'package:joparpet_app/blocs/inscricao.dart';
import 'package:joparpet_app/blocs/presenca.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authBloc = AuthBloc()..dispatch(AuthAppStarted());
  final presencaBloc = PresencaBloc(authBloc: authBloc);
  final inscricaoBloc =
      InscricaoBloc(authBloc: authBloc, presencaBloc: presencaBloc);
  final turmaBloc = TurmaBloc(authBloc: authBloc, inscricaoBloc: inscricaoBloc);
  final atividadeBloc = AtividadeBloc(authBloc: authBloc, turmaBloc: turmaBloc);
  final eventoBloc =
      EventoBloc(authBloc: authBloc, atividadeBloc: atividadeBloc);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      builder: (context) => authBloc,
    ),
    BlocProvider<EventoBloc>(
      builder: (context) => eventoBloc,
    ),
    BlocProvider<AtividadeBloc>(
      builder: (context) => atividadeBloc,
    ),
    BlocProvider<TurmaBloc>(
      builder: (context) => turmaBloc,
    ),
    BlocProvider<InscricaoBloc>(
      builder: (context) => inscricaoBloc,
    ),
    BlocProvider<PresencaBloc>(
      builder: (context) => presencaBloc,
    )
  ], child: App()));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XIII JoparPET',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: LoginPage(),
    );
  }
}
