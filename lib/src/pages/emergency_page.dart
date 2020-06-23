import 'package:animate_do/animate_do.dart';
import 'package:disenos/src/widgets/emergency_header.dart';
import 'package:disenos/src/widgets/emergency_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemBoton {

  final IconData icon;
  final String texto;
  List<Color> colors;

  ItemBoton( this.icon, this.texto,this.colors );
}

class EmergencyPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if(MediaQuery.of(context).size.height > 500){
      isLarge = true;
    }else{
      isLarge = false;
    }

    final items = <ItemBoton>[
      new ItemBoton( FontAwesomeIcons.carCrash, 'Motor Accident',[Color(0xff6989F5), Color(0xff906EF5)]),
      new ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency',[Color(0xff66A9F2), Color(0xff536CF6)]),
      new ItemBoton( FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',[Color(0xffF2D572), Color(0xffE06AA3)]),
      new ItemBoton( FontAwesomeIcons.biking, 'Awards',[Color(0xff317183), Color(0xff46997D)]),
      new ItemBoton( FontAwesomeIcons.carCrash, 'Motor Accident',[Color(0xff6989F5), Color(0xff906EF5)]),
      new ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency',[Color(0xff66A9F2), Color(0xff536CF6)]),
      new ItemBoton( FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',[Color(0xffF2D572), Color(0xffE06AA3)]),
      new ItemBoton( FontAwesomeIcons.biking, 'Awards',[Color(0xff317183), Color(0xff46997D)]),
      new ItemBoton( FontAwesomeIcons.carCrash, 'Motor Accident',[Color(0xff6989F5), Color(0xff906EF5)]),
      new ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency',[Color(0xff66A9F2), Color(0xff536CF6)]),
      new ItemBoton( FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',[Color(0xffF2D572), Color(0xffE06AA3)]),
      new ItemBoton( FontAwesomeIcons.biking, 'Awards',[Color(0xff317183), Color(0xff46997D)]),
    ];

    List<Widget> itemMap = items.map(
      (item) => FadeInLeft(
        child: EmergencyButton(
          title: item.texto, 
          icon: item.icon,
          colors: item.colors,
        ),
      )
    ).toList();

    return Scaffold(
      body:Stack(
        children: <Widget>[
           _ButtonsList(items:itemMap,isLarge: isLarge,),
           if(isLarge)
            _EmergencyHeader(),
        ],
      ),
    );
  }
}

class _ButtonsList extends StatelessWidget {
  final List<Widget> items;
  final bool isLarge;

  _ButtonsList({@required this.items,@required this.isLarge});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:(isLarge)?300.0:10.0),
      child: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: items,
        ),
      ),
    );
  }
}

class _EmergencyHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        EmergencyHeader(
          icon: FontAwesomeIcons.plus,
          title: 'Asistencia Médica',
          subTitle: 'Haz solicitado',
          colors: [Color(0xff66A9F2), Color(0xff536CF6)],
        ),
        Positioned(
          right: 30.0,
          top: 40.0,
          child: GestureDetector(
            onTap: () {print('Menú');},
            child: FaIcon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}

/*class _EmergencyHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return EmergencyHeader(
      icon: FontAwesomeIcons.userAstronaut,
      title: 'Ser Astronauta',
      colors: [Colors.orange,Colors.black],
    );
  }
}*/