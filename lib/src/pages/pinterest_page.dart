import 'package:disenos/src/theme/theme.dart';
import 'package:disenos/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => new _MenuModel(),
      child: Scaffold(
        //body: PinterestMenu(),
        body: Stack(
          children: <Widget>[
            PinterestGrid(),
            _PinterestMenuPositioned(width: width),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuPositioned extends StatelessWidget {

  final double width;

  _PinterestMenuPositioned({this.width});

  @override
  Widget build(BuildContext context) {
    final mModel = Provider.of<_MenuModel>(context);
    final themeChanger = Provider.of<ThemeChanger>(context).getCurrentTheme;

    return Positioned(
      bottom: 30.0,
      child: Container(
        width: width,
        child: Align(
          child: PinterestMenu(
            showMenu: mModel.showMenu,
            backgroundColor: themeChanger.scaffoldBackgroundColor,
            selectedColor: themeChanger.accentColor,
            items: [
              PinterestButton(icon: Icons.pie_chart,onPressed: (){print('icon pie chart');}),
              PinterestButton(icon: Icons.search,onPressed: (){print('search');}),
              PinterestButton(icon: Icons.notifications,onPressed: (){print('notifications');}),
              PinterestButton(icon: Icons.supervised_user_circle,onPressed: (){print('supervised');}),
            ],
          ),
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  PinterestGrid({Key key}) : super(key: key);

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);
  ScrollController controller = new ScrollController();
  double scrollBack = 0;

  @override
  void initState() {
    final mModel = Provider.of<_MenuModel>(context,listen: false);

    controller.addListener(() {
      if(controller.offset > scrollBack) {
        mModel.showMenu = false;
      }else{
        mModel.showMenu = true;
      }
      scrollBack = controller.offset;
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
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index: index,),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  const _PinterestItem({this.index});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: new Center(
        child: new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Text('$index'),
        ),
      )
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _showMenu = true;

  bool get showMenu => this._showMenu;

  set showMenu(bool show) {
    this._showMenu = show;
    notifyListeners();
  }
}