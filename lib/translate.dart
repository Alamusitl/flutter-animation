import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Transition extends StatefulWidget {
  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: Slide(),
        ),
        Container(
          height: 200,
          child: Scale(),
        ),
        Container(
          height: 200,
          child: Rotate(),
        ),
      ],
    );
  }
}

class Slide extends StatefulWidget {
  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          case AnimationStatus.forward:
            // TODO: Handle this case.
            break;
          case AnimationStatus.reverse:
            // TODO: Handle this case.
            break;
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0.0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _animation,
        child: Container(
          color: Colors.grey,
          margin: EdgeInsets.all(8.0),
          width: 100.0,
          height: 100.0,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

class Scale extends StatefulWidget {
  @override
  _ScaleState createState() => _ScaleState();
}

class _ScaleState extends State<Scale> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          case AnimationStatus.forward:
            // TODO: Handle this case.
            break;
          case AnimationStatus.reverse:
            // TODO: Handle this case.
            break;
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          width: 100.0,
          height: 100.0,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

class Rotate extends StatefulWidget {
  @override
  _RotateState createState() => _RotateState();
}

class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          case AnimationStatus.forward:
            // TODO: Handle this case.
            break;
          case AnimationStatus.reverse:
            // TODO: Handle this case.
            break;
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: Container(
          width: 100.0,
          height: 100.0,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
