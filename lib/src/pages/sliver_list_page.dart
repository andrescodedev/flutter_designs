import 'package:disenos/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverListPage extends StatelessWidget {
  const SliverListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _MainScroll(),
          Positioned(
            bottom: -10.0,
            right: 0.0,
            child: _ButtonList(),
          ),
        ],
      ),
    );
  }
}

class _ButtonList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeChanger = Provider.of<ThemeChanger>(context);

    return ButtonTheme(
      minWidth: size.width*0.9,
      height: 100.0,
      child: RaisedButton(
        onPressed: () {},
        color: (themeChanger.getDarkTheme)?themeChanger.getCurrentTheme.accentColor: Color(0xffED6762),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))
        ),
        child: Text(
          'CREATE A NEW LIST',
          style: TextStyle(
            color: themeChanger.getCurrentTheme.scaffoldBackgroundColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _ListItem( 'Orange', Color(0xffF08F66) ),
    _ListItem( 'Family', Color(0xffF2A38A) ),
    _ListItem( 'Subscriptions', Color(0xffF7CDD5) ),
    _ListItem( 'Books', Color(0xffFCEBAF) ),
    _ListItem( 'Orange', Color(0xffF08F66) ),
    _ListItem( 'Family', Color(0xffF2A38A) ),
    _ListItem( 'Subscriptions', Color(0xffF7CDD5) ),
    _ListItem( 'Books', Color(0xffFCEBAF) ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        /*SliverAppBar(
          floating: true,
          backgroundColor: Colors.pink,
          title: Text('Hola flutter'),
        ),*/
        SliverPersistentHeader(
          floating: true,
          delegate:_SliverCustomHeaderDelegate(
            minHeight: 150.0,
            maxHeight: 200.0,
            child: Container(
              child: _TitleSlider(),
              color: themeChanger.getCurrentTheme.scaffoldBackgroundColor,
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ...items,
            SizedBox(height: 100.0,),
          ]),
        ),
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate{
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    @required this.minHeight, 
    @required this.maxHeight, 
    @required this.child,
  });


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child,);
  }

  @override
  //(minHeight>maxHeight)?minHeight:maxHeight; una forma de validar
  double get maxExtent => maxHeight;

  @override
  //(maxHeight<minHeight)?maxHeight:minHeight; una forma de validar
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
           minHeight != oldDelegate.minHeight ||
           child     != oldDelegate.child;
  }
}

/*class _ChoresList extends StatelessWidget {
  final List<Widget> items;

  const _ChoresList({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder:(BuildContext context,int index) => items[index]
    );
  }
}*/

class _TitleSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Column(
      children: <Widget>[
        SizedBox(height: 20.0,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 5.0),
          child: Text(
            'New',
            style: TextStyle(
              color: (themeChanger.getDarkTheme)? Colors.grey :Color(0xff532128),
              fontSize: 50.0
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0,),
          child: Text('List',style: TextStyle(color: Color(0xffD93A30),fontSize: 50.0,fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }

}

class _ListItem extends StatelessWidget {
  final String title;
  final Color color;

  _ListItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 130.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
    );
  }
}