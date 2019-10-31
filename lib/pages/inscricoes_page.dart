
import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joparpet_app/blocs/inscricao.dart';
import 'package:joparpet_app/blocs/presenca.dart';
// Utils
import 'package:joparpet_app/utils/snack_bar.dart';
import 'package:joparpet_app/utils/style.dart';
// Model
import 'package:joparpet_app/models/inscricao.dart';
// Foreign
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class InscricoesPage extends StatefulWidget {
  createState() => _InscricoesPageState();
}

class _InscricoesPageState extends State<InscricoesPage> {
  final _qrReader = QRCodeReader();

  Future<void> _onRefresh(InscricaoBloc _bloc) async {
    _bloc.dispatch(InscricaoLoad(
        turma: _bloc.currentTurma, atividade: _bloc.currentAtividade));
  }

  void _selectInscricao(InscricaoModel inscricao, BuildContext context) async {
    print(inscricao.inscrito.usuario.id);
  }

  void _toScanPage(BuildContext context, InscricaoBloc _bloc) async {
    String _barcodeString = await _qrReader
        .setAutoFocusIntervalInMs(200)
        .setForceAutoFocus(true)
        .setTorchEnabled(true)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan()
        .catchError((e) {
      print(e);
      return null;
    });

    print(_barcodeString);

    if (_barcodeString == null) {
      SimpleSnackBar.showSnackBar(context, 'QRCode não encontrado');
      return;
    }

    final inscricao = _bloc.currentInscricaos
        .firstWhere((i) => i.usuarioId == _barcodeString, orElse: () => null);

    if (inscricao != null) if (_bloc.currentTurma.today == null)
      SimpleSnackBar.showSnackBar(context, 'Não há turma em atividade hoje!');
    else
      _bloc.dispatch(InscricaoApply(chosenInscricao: inscricao));
    else
      SimpleSnackBar.showSnackBar(
          context, 'Inscrito não pertence a esta turma!');
  }

  @override
  Widget build(BuildContext context) {
    final InscricaoBloc _inscricaoBloc =
        BlocProvider.of<InscricaoBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<InscricaoBloc, InscricaoState>(
          listener: (context, state) {
            if (state is InscricaoLoadFailed)
              SimpleSnackBar.showSnackBar(context, state.error.message);
          },
        ),
        BlocListener<PresencaBloc, PresencaState>(
          listener: (context, state) {
            if (state is PresencaSetSucessfull)
              SimpleSnackBar.showSnackBar(
                  context, '${state.inscricao.nome} recebeu presença!',
                  color: AppStyle.colorPigmentGreen);

            if (state is PresencaSetFailed)
              SimpleSnackBar.showSnackBar(
                  context, state.error?.message ?? 'Generic error');
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _inscricaoBloc,
        builder: (context, state) {
          final List<InscricaoModel> _inscricoes =
              (state is InscricaoLoading || state is InscricaoEmpty)
                  ? []
                  : state.inscricoes;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Inscrições - ${state.turma?.nome ?? ""} | ${state.atividade?.nome ?? ""}',
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _toScanPage(context, _inscricaoBloc),
              backgroundColor: Colors.red,
              child: Icon(
                Icons.camera_alt,
              ),
            ),
            body: LiquidPullToRefresh(
              onRefresh: () => _onRefresh(_inscricaoBloc),
              showChildOpacityTransition: false,
              height: AppStyle.pullHeight,
              color: Colors.black,
              child: ListView.builder(
                itemCount: _inscricoes.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(index.toString()),
                    ),
                    title: Text(
                      _inscricoes[index].nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(_inscricoes[index].description),
                    onTap: () => _selectInscricao(_inscricoes[index], context),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
