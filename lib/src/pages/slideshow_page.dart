import 'package:disenos/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if(MediaQuery.of(context).size.height > 500){
      isLarge = true;
    }else{
      isLarge = false;
    }

    final children = [
      Expanded(child: MySlideshow(),),
      Expanded(child: MySlideshow(),),
    ];

    return Scaffold(
      body: (isLarge)?Column(children: children,):Row(children: children,),
    );
  }
}

class MySlideshow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Slideshow(
      pointsTop: true,
      primaryBullet: 20.0,
      slides: <Widget>[
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}