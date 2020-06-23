import 'package:flutter/material.dart';
import 'dart:math'as Math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CuadradoAnimado()),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {

  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> opacityOut;
  Animation<double> moveRight;
  Animation<double> enlarge;

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    //rotation = Tween(begin: 0.0,end: 2 * Math.pi).animate(controller); Animation One
    rotation = Tween(begin: 0.0,end: 2*Math.pi).animate(
      CurvedAnimation(parent: controller,curve: Curves.easeOut)
    );

    opacity = Tween(begin: 0.1,end: 1.0).animate(
      CurvedAnimation(parent: controller,curve: Interval(0.0,0.25,curve: Curves.easeOut))
    );

    opacityOut = Tween(begin: 1.0,end: 0.1).animate(
      CurvedAnimation(parent: controller,curve: Interval(0.75,1,curve: Curves.easeOut))
    );

    moveRight = Tween(begin: 0.0,end: 200.0).animate(
      CurvedAnimation(parent: controller,curve: Curves.easeOut)
    );

    enlarge = Tween(begin: 1.0,end: 5.0).animate(
      CurvedAnimation(parent: controller,curve: Curves.easeOut)
    );

    controller.addListener(() {
      //print('status: ${controller.status}');
      if(controller.status == AnimationStatus.completed) {
        //controller.reverse();
        controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      child: _Cuadrado(),
      builder: (BuildContext context, Widget childCuadrado) {
        return Transform.translate(
          offset: Offset(moveRight.value, 0.0),
          child: Transform.rotate(
            angle: rotation.value,
            child: Opacity(
              opacity: opacity.value,
              child: Transform.scale(
                scale: enlarge.value,
                child: Opacity(
                  opacity: opacityOut.value,
                  child: childCuadrado,
                )
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Cuadrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }

}