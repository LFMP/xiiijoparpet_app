import 'package:flutter/material.dart';

enum SlideDirection { TOP_BOTTOM, BOTTOM_TOP, LEFT_RIGHT, RIGHT_LEFT }

const DIRECTION = [Offset(0, -1), Offset(0, 1), Offset(-1, 0), Offset(1, 0)];

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;
  SlideRoute({@required this.page, @required this.direction})
    : assert(page != null),
      assert(direction != null),
      super(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
          page,
          transitionDuration: Duration(milliseconds: 150),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) => SlideTransition(
            position: Tween<Offset>(
              begin: DIRECTION[direction.index],
              end: Offset.zero,
            ).animate(animation),
            child: child,
          )
        );
}
