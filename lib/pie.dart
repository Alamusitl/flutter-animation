import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _ExtraValues {
  final double startRadians = -pi / 2;
  final double innerCircleRadiusPercent = 0.6;
  final Duration animationDuration = Duration(milliseconds: 300);
  final double space = 3.0;
  final Color spaceColor = Colors.white;
}

class _PieDescribe {
  final List<num> values;
  final List<Color> colors;

  _PieDescribe({@required this.values, @required this.colors});
}

class TestPie extends StatelessWidget {
  final List<_PieDescribe> pies = [
    _PieDescribe(
      values: [400, 200, 300, 800],
      colors: [Colors.red, Colors.blue, Colors.yellow, Colors.green],
    ),
    _PieDescribe(
      values: [600, 200, 700, 300],
      colors: [Colors.red, Colors.blue, Colors.yellow, Colors.black],
    ),
    _PieDescribe(
      values: [700, 800, 400, 600],
      colors: [Colors.red, Colors.blue, Colors.yellow, Colors.green],
    ),
  ];

  int _currentNum = 0;

  @override
  Widget build(BuildContext context) {
    PieChart pieChart = PieChart(describe: pies[_currentNum]);
    return Material(
      color: Colors.grey,
      child: Center(
        child: InkWell(
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: pieChart,
          ),
          onTap: () {
            if (_currentNum < 2) {
              _currentNum++;
            } else {
              _currentNum = 0;
            }
            pieChart.changePies(pies[_currentNum]);
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PieChart extends StatefulWidget {
  final _PieDescribe describe;
  final _ExtraValues values = new _ExtraValues();

  _PieChartState _state;

  PieChart({Key key, this.describe}) : super(key: key);

  @override
  _PieChartState createState() {
    _state = _PieChartState();
    return _state;
  }

  void changePies(_PieDescribe describe) {
    _state.changePies(describe);
  }
}

class _PieChartState extends State<PieChart> with TickerProviderStateMixin {
  _ExtraValues _values;
  _PieDescribe _describe;

  AnimationController _controller;
  CurvedAnimation _animation;

  _PiesPainter _painter;

  @override
  void initState() {
    super.initState();
    _describe = widget.describe;
    _values = widget.values;

    _controller = AnimationController(
      vsync: this,
      duration: _values.animationDuration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<double> initValues() {
    List<double> radians = List<double>();
    num totalValue = 0.0;
    _describe.values.forEach((num) {
      totalValue += num;
    });
    _describe.values.forEach((num) {
      double theRadians = num / totalValue * 2 * pi;
      radians.add(theRadians);
    });
    return radians;
  }

  void changePies(_PieDescribe describe) {
    _describe = describe;
    List<double> radians = initValues();
    _painter.changeRadians(radians, describe.colors);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    List<double> radians = initValues();
    _painter = _PiesPainter(
      radians,
      _describe.colors,
      _values,
      _animation,
      _values.startRadians,
    );

    return SizedBox.expand(
      child: CustomPaint(
        painter: _painter,
      ),
    );
  }
}

class _PiesPainter extends CustomPainter {
  final _ExtraValues values;
  final CurvedAnimation animation;
  final double startRadians;
  final Paint painter = Paint();
  final List<Offset> endPoints = List<Offset>();

  // 上一次扇形弧度数据
  List<double> lastRadians = List<double>();

  // 当前扇形的弧度数据
  List<double> radians;

  // 当前扇形的颜色
  List<Color> colors;

  // 所包含的扇形数量
  int num;

  _PiesPainter(
    this.radians,
    this.colors,
    this.values,
    this.animation,
    this.startRadians,
  ) : super(repaint: animation) {
    num = radians.length;
    painter.style = PaintingStyle.fill;
    painter.strokeWidth = values.space;
    for (int i = 0; i < num; i++) {
      lastRadians.add(0.0);
    }
  }

  void changeRadians(List<double> newRadians, List<Color> colors) {
    // 老数组赋值
    lastRadians = radians;
    // 新数组赋值
    radians = newRadians;
    // 确定绘制的循环次数
    num = radians.length > lastRadians.length
        ? radians.length
        : lastRadians.length;
    for (int i = 0; i < num; i++) {
      // 如果新数组较大，则为老数组添加多余的值，0.0
      if (lastRadians.length <= 1) {
        lastRadians.add(0.0);
      }
      // 如果老数组较大，则为新数组添加多余的值，0.0，并且颜色需要对应添加进来
      if (radians.length <= 1) {
        radians.add(0.0);
        colors.add(this.colors[i]);
      }
    }
    // 设置颜色
    this.colors = colors;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 剪切画布
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect);

    // 扇形图的中心点
    Offset center = Offset(size.width / 2, size.height / 2);
    // 外部圆半径
    double outerRadius = size.width / 2;
    // 内部圆半径
    double innerRadius = outerRadius * values.innerCircleRadiusPercent;

    double pieStartRadians = startRadians;
    double linesRadians = 0.0;
    for (int i = 0; i < num; i++) {
      // 当前每个扇形弧度的计算，
      double currentRadians =
          lastRadians[i] + (radians[i] - lastRadians[i]) * animation.value;

      // 外部圆
      painter.color = colors[i];
      Rect outerRect = Rect.fromCircle(center: center, radius: outerRadius);
      canvas.drawArc(outerRect, pieStartRadians, currentRadians, true, painter);

      pieStartRadians = pieStartRadians + currentRadians;
      linesRadians = linesRadians + currentRadians;
      double endX = outerRadius + outerRadius * sin(linesRadians);
      double endY = outerRadius - outerRadius * cos(linesRadians);
      endPoints.add(Offset(endX, endY));
    }

    // 内部圆
    painter.color = values.spaceColor;
    Rect innerRect = Rect.fromCircle(center: center, radius: innerRadius);
    canvas.drawArc(innerRect, 0.0, 2 * pi, true, painter);

    // 绘制相邻扇形中间的间隔线
    endPoints.forEach((endPoint) {
      canvas.drawLine(center, endPoint, painter);
    });
    endPoints.clear();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
