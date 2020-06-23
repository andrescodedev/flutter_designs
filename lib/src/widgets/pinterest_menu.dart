import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestMenu extends StatefulWidget {
  final bool showMenu;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final List<PinterestButton> items;
  
  PinterestMenu({this.showMenu=true,this.backgroundColor=Colors.white,this.selectedColor=Colors.pink,
                  this.unselectedColor=Colors.blueGrey,@required this.items});

  @override
  _PinterestMenuState createState() => _PinterestMenuState();
}

class _PinterestMenuState extends State<PinterestMenu> {
  /*final List<PinterestButton> items = [
    PinterestButton(icon: Icons.pie_chart,onPressed: (){print('icon pie chart');}),
    PinterestButton(icon: Icons.search,onPressed: (){print('search');}),
    PinterestButton(icon: Icons.notifications,onPressed: (){print('notifications');}),
    PinterestButton(icon: Icons.supervised_user_circle,onPressed: (){print('supervised');}),
  ];*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new _MenuModel(),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: (widget.showMenu)?1:0,
        child: Builder(
          builder: (context) {
            Provider.of<_MenuModel>(context,).backgroundColor = widget.backgroundColor;
            Provider.of<_MenuModel>(context,).selectedColor = widget.selectedColor;
            Provider.of<_MenuModel>(context,).unselectedColor = widget.unselectedColor;
            
            return _PinterestMenuBackground(
              child: _MenuItems(menuItems:widget.items,),
            );
          },
        )
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  
  _PinterestMenuBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    final mModel = Provider.of<_MenuModel>(context);

    return Container(
      width: 250.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: mModel.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10.0,
            //spreadRadius: -5.0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems({@required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuItem(index: i,item: menuItems[i],)),
    );
  }
}

class _PinterestMenuItem extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PinterestMenuItem({this.index, this.item});

  @override
  Widget build(BuildContext context) {
    final mModel= Provider.of<_MenuModel>(context);
    return GestureDetector(
      onTap: (){
        mModel.itemSelected = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child:Icon(
          item.icon,
          color: (mModel.itemSelected==index)?mModel.selectedColor:mModel.unselectedColor,
          size: (mModel.itemSelected==index)?30.0:20.0,
        ),
      ),
    );
  }
}

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({@required this.icon, @required this.onPressed});
}

class _MenuModel with ChangeNotifier {

  int _itemSelected      = 0;
  Color _backgroundColor = Colors.white;
  Color _selectedColor   = Colors.pink;
  Color _unselectedColor = Colors.blueGrey;

  int get itemSelected => this._itemSelected;
  Color get backgroundColor => this._backgroundColor;
  Color get selectedColor => this._selectedColor;
  Color get unselectedColor => this._unselectedColor;

  set itemSelected(int index) {
    this._itemSelected = index;
    notifyListeners();
  }

  set backgroundColor(Color color) {
    this._backgroundColor = color;
  }

  set selectedColor(Color color) {
    this._selectedColor = color;
  }

  set unselectedColor(Color color) {
    this._unselectedColor = color;
  }

}