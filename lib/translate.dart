import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FlutterLogo(),
    );
  }
}

class Example extends StatelessWidget {
  final Widget child;

  Example(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: EdgeInsets.only(bottom: 8.0),
      height: 100.0,
      child: child,
    );
  }
}

class Transition extends StatefulWidget {
  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Example(Slide()),
            Example(Scale()),
            Example(Rotate()),
            Example(Size()),
            Example(Fade()),
            Example(AlignAnim()),
            Example(TextStyleAnim()),
            Example(DecorationAnim()),
            Example(RelativeRectSample()),
            Example(AnimationBuilderSample()),
          ],
        ),
      ),
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
    )..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
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
        child: Logo(),
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
            break;
          case AnimationStatus.reverse:
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
        child: Logo(),
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
            break;
          case AnimationStatus.reverse:
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
        child: Logo(),
      ),
    );
  }
}

class Size extends StatefulWidget {
  @override
  _SizeState createState() => _SizeState();
}

class _SizeState extends State<Size> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        child: Logo(),
      ),
    );
  }
}

/// AnimatedOpacity
class Fade extends StatefulWidget {
  @override
  _FadeState createState() => _FadeState();
}

class _FadeState extends State<Fade> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
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
      child: FadeTransition(
        opacity: _animation,
        child: Logo(),
      ),
    );
  }
}

/// AnimatedAlign
class AlignAnim extends StatefulWidget {
  @override
  _AlignAnimState createState() => _AlignAnimState();
}

class _AlignAnimState extends State<AlignAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _animation = Tween(begin: Alignment.centerLeft, end: Alignment.centerRight)
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
      child: AlignTransition(
        alignment: _animation,
        child: Logo(),
      ),
    );
  }
}

/// AnimatedDefaultTextStyle
class TextStyleAnim extends StatefulWidget {
  @override
  _TextStyleAnimState createState() => _TextStyleAnimState();
}

class _TextStyleAnimState extends State<TextStyleAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<TextStyle> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _animation = TextStyleTween(
      begin: TextStyle(fontSize: 14, color: Colors.red),
      end: TextStyle(fontSize: 22, color: Colors.black),
    ).animate(_controller);
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
      child: DefaultTextStyleTransition(
        style: _animation,
        child: Text('字体动画'),
      ),
    );
  }
}

class DecorationAnim extends StatefulWidget {
  @override
  _DecorationState createState() => _DecorationState();
}

class _DecorationState extends State<DecorationAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Decoration> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _animation = DecorationTween(
      begin: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      end: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
    ).animate(_controller);
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
      child: DecoratedBoxTransition(
        decoration: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Logo(),
        ),
      ),
    );
  }
}

class RelativeRectSample extends StatefulWidget {
  @override
  _RelativeRectSampleState createState() => _RelativeRectSampleState();
}

class _RelativeRectSampleState extends State<RelativeRectSample>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<RelativeRect> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(10.0, 10.0, 10.0, 10.0),
      end: RelativeRect.fromLTRB(50.0, 50.0, 50.0, 50.0),
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PositionedTransition(
          rect: _animation,
          child: Logo(),
        ),
      ],
    );
  }
}

class AnimationBuilderSample extends StatefulWidget {
  @override
  _AnimationBuilderSampleState createState() => _AnimationBuilderSampleState();
}

class _AnimationBuilderSampleState extends State<AnimationBuilderSample>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addStatusListener((status) {})
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        child: Logo(),
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * pi,
            child: Logo(),
          );
        },
      ),
    );
  }
}
