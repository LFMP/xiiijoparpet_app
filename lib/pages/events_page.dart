import 'dart:convert';
import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joparpet_app/blocs/evento.dart';
// Utils
import 'package:joparpet_app/utils/snack_bar.dart';
import 'package:joparpet_app/utils/style.dart';
import 'package:joparpet_app/utils/slider.dart';
// Model
import 'package:joparpet_app/models/evento.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// Pages
import 'package:joparpet_app/pages/atividades_page.dart';

class EventsPage extends StatefulWidget {
  createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // final _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onRefresh(EventoBloc _bloc) async {
    _bloc.dispatch(EventoLoad());
  }

  _selectEvento(
    EventoModel evento,
    EventoBloc _bloc,
    BuildContext context,
  ) async {
    _bloc.dispatch(EventoApply(chosenEvento: evento));
    await Navigator.of(context).push(SlideRoute(
        page: AtividadesPage(), direction: SlideDirection.BOTTOM_TOP));
  }

  @override
  Widget build(BuildContext context) {
    final EventoBloc _eventoBloc = BlocProvider.of<EventoBloc>(context);

    return BlocListener(
        bloc: _eventoBloc,
        listener: (context, state) {
          if (state is EventoLoadFailed)
            SimpleSnackBar.showSnackBar(context, state.error.message);
        },
        child: BlocBuilder(
          bloc: _eventoBloc,
          builder: (context, state) {
            if (state is EventoEmpty) _eventoBloc.dispatch(EventoLoad());

            final _events = state is EventoLoading ? [] : state.events;

            return Scaffold(
                appBar: AppBar(
                  title: Text('Eventos'),
                ),
                body: LiquidPullToRefresh(
                  onRefresh: () => _onRefresh(_eventoBloc),
                  showChildOpacityTransition: false,
                  height: AppStyle.pullHeight,
                  color: Colors.black,
                  child: ListView.builder(
                      itemCount: _events.length,
                      itemBuilder: (context, index) => Card(
                            child: ListTile(
                              leading: ClipOval(
                                child: Image.memory(base64Decode(_events[index]
                                    .foto
                                    .toString()
                                    .substring(23))),
                              ),
                              title: Text(
                                _events[index].nome,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_events[index].description),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.teal[200],
                              ),
                              onTap: () => _selectEvento(
                                  _events[index], _eventoBloc, context),
                            ),
                          )),
                ));
          },
        ));
  }
}
