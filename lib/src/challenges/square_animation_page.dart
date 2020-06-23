import 'package:flutter/material.dart';

class SquareAnimationPage extends StatelessWidget {
  const SquareAnimationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _SquareAnimation(),
      ),
    );
  }
}

class _SquareAnimation extends StatefulWidget {
  _SquareAnimation({Key key}) : super(key: key);

  @override
  __SquareAnimationState createState() => __SquareAnimationState();
}

class __SquareAnimationState extends State<_SquareAnimation> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> moveRight;
  Animation<double> moveLeft;
  Animation<double> moveTop;
  Animation<double> moveDown;
  

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    moveRight = Tween(begin: 0.0,end: 100.0).animate(
      CurvedAnimation(parent: controller,curve: Interval(0.0, 0.25,curve: Curves.bounceOut))
    );

    moveTop = Tween(begin: 0.0,end: -100.0).animate(
      CurvedAnimation(parent: controller,curve: Interval(0.25,0.5,curve: Curves.bounceOut))
    );

    moveLeft = Tween(begin: 0.0,end: -100.0).animate(
      CurvedAnimation(parent: controller,curve: Interval(0.5,0.75,curve: Curves.bounceOut))
    );

    moveDown = Tween(begin: 0.0,end: 100.0).animate(
      CurvedAnimation(parent: controller,curve:Interval(0.75,1.0,curve: Curves.bounceOut))
    );

    controller.addListener(() {
      if(controller.status == AnimationStatus.completed){
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
      child: _square(),
      builder: (BuildContext context,Widget child) {
        return Transform.translate(
          offset: Offset(moveRight.value,moveTop.value),
          child: Transform.translate(
            offset: Offset(moveLeft.value,moveDown.value),
            child: child,
          ),
        );
      },
    );
  }

  Widget _square() {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.pink,
      ),
    );
  }
}

