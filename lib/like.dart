import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Like extends StatefulWidget {
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> with TickerProviderStateMixin {
  AnimationController controller;
  Animation sizeAnimation;
  Animation colorAnimation;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    );
    sizeAnimation = Tween(begin: 32.0, end: 40.0).animate(curvedAnimation);
    colorAnimation =
        Tween(begin: Colors.grey, end: Colors.red).animate(curvedAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimationHeart([sizeAnimation, colorAnimation], controller),
    );
  }
}

class AnimationHeart extends AnimatedWidget {
  final List animations;
  final AnimationController controller;

  AnimationHeart(this.animations, this.controller)
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      iconSize: animations[0].value,
      color: animations[1].value,
      onPressed: () {
        switch (controller.status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          default:
            controller.forward();
            break;
        }
      },
    );
  }
}
