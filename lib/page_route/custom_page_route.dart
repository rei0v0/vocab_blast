import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRoute<T> {

  CustomPageRoute( {required this.builder}) : super();

  final WidgetBuilder builder;


  @override
  Color get barrierColor => Colors.white;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // pop時のスライドアウトのアニメーションを指定
    if (animation.status == AnimationStatus.reverse) {
      // pop時のトランジションを指定
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(
    milliseconds: 200, // 変化にかかる時間を指定
  );

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  bool get canPop => false;


}