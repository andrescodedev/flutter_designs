import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondColor;
  final double circularWidth;
  final double arcWidth;
  final Gradient gradient;

  RadialProgress({
    @required this.percentage, this.primaryColor=Colors.blue, this.secondColor=Colors.grey, this.circularWidth=5.0,
    this.arcWidth=10.0,this.gradient});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double percentagePrevious;

  @override
  void initState() {
    percentagePrevious = widget.percentage;
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final differenceAnimated = widget.percentage - percentagePrevious;
    percentagePrevious = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter:_MyRadialProgressPainter(
              percentagePainter: (widget.percentage-differenceAnimated)+(differenceAnimated*controller.value),
              primaryColorPainter: widget.primaryColor,
              secondColorPainter: widget.secondColor,
              circularWidthPainter: widget.circularWidth,
              arcWidthPainter: widget.arcWidth,
              gradient: widget.gradient,
            ),
          ),
        );
      },
    );
  }
}

class _MyRadialProgressPainter extends CustomPainter {
  final double percentagePainter;
  final Color primaryColorPainter;
  final Color secondColorPainter;
  final double circularWidthPainter;
  final double arcWidthPainter;
  final Gradient gradient;

  _MyRadialProgressPainter({
    @required this.percentagePainter,@required this.primaryColorPainter,@required this.secondColorPainter,@required this.circularWidthPainter, 
    @required this.arcWidthPainter,this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = new Rect.fromCircle(center: Offset(0.0,0.0),radius: 100.0);

    //Circle
    final pencilCircular = Paint()
      ..strokeWidth = circularWidthPainter
      ..color = secondColorPainter
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, pencilCircular);

    //Arc
    Paint pencilArc;
    if(primaryColorPainter!=null){
      pencilArc = new Paint()
      ..strokeWidth = arcWidthPainter
      ..color = primaryColorPainter
      //..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    }else{
      pencilArc = Paint()
      ..strokeWidth = arcWidthPainter
      //..color = primaryColorPainter
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    }

    //part that should be fill
    double arcAngle = 2 * pi * (percentagePainter / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      pencilArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
