import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final double delay;
  FadeAnimation(this.delay, this.child);
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    controller.forward();
  }

  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: FadeTransition(
            opacity: animation,
            child: widget.child
        )
    );
  }
}