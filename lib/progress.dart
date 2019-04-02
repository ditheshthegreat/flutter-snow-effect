import 'dart:core';

import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color color;
  CircularProgress(
      {@required this.size,
      this.backgroundColor = Colors.grey,
      this.color = Colors.blue});

  @override
  _CircularProgress createState() => new _CircularProgress();
}

class _CircularProgress extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000))
      ..repeat();
    animation = Tween(begin: 0.0, end: 360.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new CustomPaint(
          painter: new CircularCanvas(
              progress: animation.value,
              backgroundColor: widget.backgroundColor,
              color: widget.color),
          size: new Size(widget.size, widget.size),
        ),
        new Text(
          '${(animation.value / 360 * 100).round()}%',
          style: new TextStyle(
              color: widget.color,
              fontSize: widget.size / 5,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class CircularCanvas extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color color;

  CircularCanvas(
      {this.progress,
      this.backgroundColor = Colors.grey,
      this.color = Colors.blue});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint
      ..color = backgroundColor
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        new Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    Rect rect = new Offset(0.0, 0.0) & size;
//    paint..shader = new LinearGradient(colors: [Colors.white, color]
//    ,begin: Alignment.topRight, end: Alignment.bottomLeft).createShader(rect);

    canvas.drawArc(new Offset(0.0, 0.0) & new Size(size.width, size.width),
        -90.0 * 0.0174533, progress * 0.0174533, false, paint..color = color);
  }

  @override
  bool shouldRepaint(CircularCanvas oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
