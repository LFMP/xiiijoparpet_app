import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Bloc
import 'package:joparpet_app/blocs/auth.dart';
import 'package:joparpet_app/blocs/evento.dart';
// Pages
import 'package:joparpet_app/pages/events_page.dart';
// Utils
import 'package:joparpet_app/utils/style.dart';
import 'package:joparpet_app/utils/slider.dart';
import 'package:joparpet_app/utils/snack_bar.dart';
// Widgets
import 'package:joparpet_app/widgets/commons/loading_widget.dart';
// Models
import 'package:joparpet_app/models/authorization.dart';

import 'atividades_page.dart';

class LoginPage extends StatelessWidget {

  final _userController = TextEditingController();
  final _passController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {

    final _authBloc = BlocProvider.of<AuthBloc>(context);

    void _sendLogin() => _authBloc.dispatch(
      AuthLogin(
        request: AuthRequest(
          username: _userController.text,
          password: _passController.text
        )
      )
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        
        if (state is AuthUnauthenticated) {
          SimpleSnackBar.showSnackBar(
            context,
            state.message
          );
        }

        if (state is AuthAuthenticated) {        
          Navigator.of(context).pushAndRemoveUntil(
              SlideRoute(
                  page: BlocProvider<EventoBloc>(
                    builder: (context) => BlocProvider.of<EventoBloc>(context),
                    child: EventsPage(),
                  ),
                  direction: SlideDirection.BOTTOM_TOP),
              (_) => false);
        }
      },
      child: BlocBuilder(
        bloc: _authBloc,
        builder: (context, state){
           
          final _child = state is AuthLoading ? LoadingWidget()
          : Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppStyle.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(60),),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black
                      ),
                    ),
                  ),
                  onPressed: () => _sendLogin()
                )
              ),
            );

          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset(
                      "assets/LogoBranca.png",
                      color: AppStyle.colorWhite
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    // autofocus: true,
                    controller: _userController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail ou username",
                      labelStyle: TextStyle(
                        color: AppStyle.colorWhite,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: AppStyle.colorWhite
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // autofocus: true,
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(
                        color: AppStyle.colorWhite,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: AppStyle.colorWhite
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _child,
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          );
        }
      )
    );
  }
}