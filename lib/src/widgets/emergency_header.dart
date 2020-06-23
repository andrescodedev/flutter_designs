import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmergencyHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final List<Color> colors;

  EmergencyHeader({this.icon=FontAwesomeIcons.plus, this.title='Asistencia Médica', 
                          this.subTitle='Haz solicitado', this.colors= const[Color(0xff526BF6),Color(0xff67ACF2),]});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => _HeaderModel(),
      child: Builder(
        builder: (BuildContext context) {
          final hModel       = Provider.of<_HeaderModel>(context);
          hModel.setIcon     = icon;
          hModel.setTitle    = title;
          hModel.setSubTitle = subTitle;
          hModel.setColors   = colors;

          return Stack(
            children: <Widget>[
              _HeaderBackground(),
              _ShadowPlusPositioned(),
              _TextIconColumn(),
            ],
          );
        },
      ),
    );
  }
}

class _TextIconColumn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final hModel = Provider.of<_HeaderModel>(context);

    return Column(
      children: <Widget>[
        SizedBox(
          height: 80.0,
          width: double.infinity,
        ),
        Text(hModel.getSubTitle,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white.withOpacity(0.7),
            )),
        SizedBox(
          height: 20.0,
        ),
        Text(
          hModel.getTitle,
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0,),
        FaIcon(hModel.getIcon,size: 80.0,color: Colors.white,)
      ],
    );
  }
}

class _ShadowPlusPositioned extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final hModel = Provider.of<_HeaderModel>(context);

    return Positioned(
      top: -50.0,
      left: -70.0,
      child: FaIcon(
        hModel.getIcon,
        size: 250.0,
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hModel = Provider.of<_HeaderModel>(context);

    return Container(
      width: double.infinity,
      height: 300.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: hModel.getColors,
          )),
    );
  }
}

class _HeaderModel with ChangeNotifier {
  IconData _icon   = FontAwesomeIcons.plus;
  String _title    = 'Asistencia Médica';
  String _subTitle = 'Haz solicitado';
  List<Color> _colors = [Color(0xff526BF6),Color(0xff67ACF2),];

  IconData get getIcon => this._icon;
  String get getTitle => this._title;
  String get getSubTitle => this._subTitle;
  List<Color> get getColors => this._colors;

  set setIcon(IconData icon) {
    this._icon = icon;
  }

  set setTitle(String title) {
    this._title = title;
  }

  set setSubTitle(String subTitle) {
    this._subTitle = subTitle;
  }

  set setColors(List<Color> colors) {
    this._colors = colors;
  }
}
