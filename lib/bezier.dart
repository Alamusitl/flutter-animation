import 'dart:math';

import 'package:flutter/material.dart';

class Bezier extends StatefulWidget {
  @override
  _BezierState createState() => _BezierState();
}

class _BezierState extends State<Bezier> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  double _height = 120;
  double _offset = pi;

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
            break;
          case AnimationStatus.forward:
            // TODO: Handle this case.
            break;
          case AnimationStatus.reverse:
            // TODO: Handle this case.
            break;
          case AnimationStatus.completed:
            break;
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: _height,
          width: constraints.biggest.width,
          child: CustomPaint(
            foregroundPainter: _BezierPainter(_animation.value + _offset),
          ),
        );
      },
    );
  }
}

class _BezierPainter extends CustomPainter {
  final double value;

  _BezierPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.black45.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
