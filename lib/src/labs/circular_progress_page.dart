import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  CircularProgressPage({Key key}) : super(key: key);

  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin {
  double porcentage = 0.0;
  double newPorcentage = 0.0;
  AnimationController controller;

  @override
  void initState() { 
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    controller.addListener(() { 
      //print('controller value: ${controller.value}');
      setState(() {
        porcentage = lerpDouble(porcentage, newPorcentage, controller.value);
      });
    });
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
        onPressed: () {
          setState(() {
            porcentage = newPorcentage;
            newPorcentage += 10.0;
            if (newPorcentage > 100) {
              newPorcentage = 0.0;
              porcentage = 0.0;
            }
            controller.forward(from: 0.0);
          });
        },
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 300.0,
          height: 300.0,
          //color: Colors.red,
          child: CustomPaint(
            painter: _MyCircularProgressPainter(porcentage),
          ),
        ),
      ),
    );
  }
}

class _MyCircularProgressPainter extends CustomPainter {
  final double porcentage;

  _MyCircularProgressPainter(this.porcentage);

  @override
  void paint(Canvas canvas, Size size) {
    //Circle
    final pencilCircular = Paint()
      ..strokeWidth = 5.0
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, pencilCircular);

    //Arc
    final pencilArc = Paint()
      ..strokeWidth = 10.0
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    //part that should be fill
    double arcAngle = 2 * pi * (porcentage / 100);
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
