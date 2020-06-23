import 'package:disenos/src/models/slide_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(child: _Slides()),
            _Dots(),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Dot(index: 0.0,),
          _Dot(index: 1.0,),
          _Dot(index: 2.0,),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double index;

  _Dot({this.index});

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 12.0,
      height: 12.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5) ? Colors.pink:Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key key}) : super(key: key);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() { 
      //print('Página actual: ${pageViewController.page}');
      //Actualizar el provider slidermodel
      Provider.of<SliderModel>(context,listen: false).currentPage = pageViewController.page;
    });
  }

  @override
  void dispose() { 
    pageViewController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: <Widget>[
          _Slide(
            svg: 'assets/svgs/slide-1.svg',
          ),
          _Slide(
            svg: 'assets/svgs/slide-2.svg',
          ),
          _Slide(
            svg: 'assets/svgs/slide-3.svg',
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;

  _Slide({@required this.svg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30.0),
      child: SvgPicture.asset(svg),
    );
  }
}
