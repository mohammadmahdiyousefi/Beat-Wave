import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void customNavigator(
    {required final BuildContext context, required final Widget page}) {
  Navigator.push(
      context,
      PageRouteBuilder(
        // transitionDuration: const Duration(milliseconds: 360),
        // reverseTransitionDuration: const Duration(milliseconds: 360),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        },
      ));
}
