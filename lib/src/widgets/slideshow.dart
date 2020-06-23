import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {

  final List<Widget> slides;
  final bool pointsTop;
  final Color colorOfSelected;
  final Color colorOfUnselected;
  final double primaryBullet;
  final double secondBullet;

  Slideshow({@required this.slides,this.pointsTop=false,this.colorOfSelected=Colors.pink,this.colorOfUnselected=Colors.grey,
              this.primaryBullet=15.0,this.secondBullet=12.0});



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _SlideshowModel(),
      child: SafeArea(
        child: Builder(
          builder: (BuildContext context) {

            Provider.of<_SlideshowModel>(context).colorOfSelected = colorOfSelected;
            Provider.of<_SlideshowModel>(context).colorOfUnselected = colorOfUnselected;
            Provider.of<_SlideshowModel>(context).primaryBullet = primaryBullet;
            Provider.of<_SlideshowModel>(context).secondBullet = secondBullet;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (pointsTop) _Dots(totalSlides: slides.length,),
                Expanded(child: _Slides(slides:slides,)),
                if (!pointsTop)_Dots(totalSlides: slides.length,),
              ],
            );
          },
        )
      ),
    );
  }
}

class _Dots extends StatelessWidget {

  final int totalSlides;

  _Dots({@required this.totalSlides});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(index: i,)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  

  _Dot({@required this.index,});

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    final size = (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) ? ssModel.primaryBullet:ssModel.secondBullet;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size,
      height:size,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) ? ssModel.colorOfSelected:ssModel.colorOfUnselected,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  _Slides({@required this.slides});

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() { 
      Provider.of<_SlideshowModel>(context,listen: false).currentPage = pageViewController.page;
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
        children: widget.slides.map((slide) => _Slide(slide: slide,)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  _Slide({@required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30.0),
      child: slide,
    );
  }
}

class _SlideshowModel with ChangeNotifier{
  double _currentPage = 0;
  Color _colorOfSelected;
  Color _colorOfUnselected;
  double _primaryBullet;
  double _secondBullet;

  double get currentPage => this._currentPage;

  Color get colorOfSelected => this._colorOfSelected;

  Color get colorOfUnselected => this._colorOfUnselected;

  double get primaryBullet => this._primaryBullet;

  double get secondBullet => this._secondBullet;

  set currentPage(double currentPage){
    this._currentPage = currentPage;
    notifyListeners();
  }

  set colorOfSelected(Color colorSelected) {
    this._colorOfSelected = colorSelected;
  }

  set colorOfUnselected(Color colorUnselected) {
    this._colorOfUnselected = colorUnselected;
  }

  set primaryBullet(double width) {
    this._primaryBullet = width;
  } 

  set secondBullet(double height) {
    this._secondBullet = height;
  }
}
