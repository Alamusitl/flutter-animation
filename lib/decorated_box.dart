import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DecoratedBox extends StatefulWidget {
  @override
  _DecoratedBoxState createState() => _DecoratedBoxState();
}

class _DecoratedBoxState extends State<DecoratedBox>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Decoration> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = DecorationTween(
      begin: BoxDecoration(),
      end: BoxDecoration(),
    ) as Animation<Decoration>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DecoratedBoxTransition'),
      ),
      body: Center(
        child: DecoratedBoxTransition(
          position: DecorationPosition.background,
          decoration: animation,
          child: Container(
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
