import 'package:flutter/material.dart';
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joparpet_app/blocs/atividade.dart';
// Utils
import 'package:joparpet_app/utils/snack_bar.dart';
import 'package:joparpet_app/utils/style.dart';
import 'package:joparpet_app/utils/slider.dart';
// Model
import 'package:joparpet_app/models/atividade.dart';
// Foreign
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// Pages
import 'package:joparpet_app/pages/turmas_page.dart';

class AtividadesPage extends StatefulWidget {
  createState() => _AtividadesPageState();
}

class _AtividadesPageState extends State<AtividadesPage> {
  final _searchController = TextEditingController();
  Widget _appBarSearchTitle;
  IconData _searchIcon;
  String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {
          _searchQuery = _searchController.text;
        }));
    _searchIcon = Icons.search;
    _appBarSearchTitle = TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: AppStyle.colorWhite,
        ),
        hintText: 'Search...',
        hintStyle: TextStyle(
          color: AppStyle.colorWhite,
        ),
      ),
      style: TextStyle(
        color: AppStyle.colorWhite,
      ),
    );
    _searchQuery = '';
  }

  void _refreshSearch(String text) {
    setState(() {
      if (_searchIcon == Icons.search) {
        _searchIcon = Icons.close;
      } else {
        this._searchIcon = Icons.search;
        _searchController.clear();
      }
    });
  }

  Future<void> _onRefresh(AtividadeBloc _bloc) async {
    _bloc.dispatch(AtividadeLoad(evento: _bloc.currentEvento));
  }

  _selectAtividade(
    AtividadeModel atividade,
    AtividadeBloc _bloc,
    BuildContext context,
  ) async {
    _bloc.dispatch(AtividadeApply(chosenAtividade: atividade));
    await Navigator.of(context).push(
        SlideRoute(page: TurmasPage(), direction: SlideDirection.BOTTOM_TOP));
  }

  @override
  Widget build(BuildContext context) {
    final AtividadeBloc _atividadeBloc =
        BlocProvider.of<AtividadeBloc>(context);

    return BlocListener(
      bloc: _atividadeBloc,
      listener: (context, state) {
        if (state is AtividadeLoadFailed)
          SimpleSnackBar.showSnackBar(context, state.error.message);
      },
      child: BlocBuilder(
        bloc: _atividadeBloc,
        builder: (context, state) {
          final List<AtividadeModel> _current =
              (state is AtividadeLoading || state is AtividadeEmpty)
                  ? []
                  : state.atividades;

          final List<AtividadeModel> _atividades = _searchQuery.isNotEmpty
              ? _current
                  .where((a) =>
                      a.nome.toLowerCase().contains(_searchQuery.toLowerCase()))
                  .toList()
              : _current;

          return Scaffold(
            appBar: AppBar(
              title: _searchIcon == Icons.search
                  ? Text('Atividades - ${state.evento?.nome ?? ""}')
                  : _appBarSearchTitle,
              actions: <Widget>[
                IconButton(
                  icon: Icon(_searchIcon),
                  onPressed: () => _refreshSearch(_searchController.text),
                )
              ],
            ),
            body: LiquidPullToRefresh(
              onRefresh: () => _onRefresh(_atividadeBloc),
              showChildOpacityTransition: false,
              height: AppStyle.pullHeight,
              color: Colors.black,
              child: ListView.builder(
                itemCount: _atividades.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(
                      _atividades[index].nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _atividades[index].categoriaNome,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.teal[200],
                    ),
                    onTap: () => _selectAtividade(
                      _atividades[index],
                      _atividadeBloc,
                      context,
                    ),
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
