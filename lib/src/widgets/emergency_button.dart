import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmergencyButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> colors;

  EmergencyButton({@required this.title,@required this.icon,this.colors=const [Color(0xff6989F5),
            Color(0xff906EF5),]});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _EmergencyModel(),
      child: Builder(
        builder: (BuildContext context) {
          final eModel     = Provider.of<_EmergencyModel>(context);
          eModel.setTitle  = title;
          eModel.setIcon   = icon;
          eModel.setColors = colors;

          return _ButtonBackgroundColor();
        },
      )
    );
  }
}

class _ButtonElements extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final eModel     = Provider.of<_EmergencyModel>(context);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(eModel.getIcon,color: Colors.white,size: 40.0,),
              SizedBox(width: 20.0,),
              Text(
                eModel.getTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
          SizedBox(width: 20.0,),
          FaIcon(FontAwesomeIcons.chevronRight,color: Colors.white,)
        ],
      ),
    );
  }
}

class _ButtonBackgroundColor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final eModel     = Provider.of<_EmergencyModel>(context);

    return Container(
      width: double.infinity,
      height: 100.0,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.5),blurRadius: 10.0,offset: Offset(4.0,6.0)),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: eModel.getColors,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            _ButtonElements(),
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon(eModel.getIcon,size: 150.0,color: Colors.white.withOpacity(0.3),),
            )
          ],
        ),
      ),
    );
  }
}

class _EmergencyModel with ChangeNotifier {
  String _title;
  IconData _icon;
  List<Color> _colors = [Color(0xff6989F5),Color(0xff906EF5),];

  String get getTitle => this._title;
  IconData get getIcon => this._icon;
  List<Color> get getColors => this._colors;

  set setTitle(String title) {
    this._title = title;
  }

  set setIcon(IconData icon) {
    this._icon = icon;
  }

  set setColors(List<Color> colors) {
    this._colors = colors;
  }
}