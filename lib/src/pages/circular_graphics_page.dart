import 'package:disenos/src/theme/theme.dart';
import 'package:disenos/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircularGraphicsPage extends StatefulWidget {
  CircularGraphicsPage({Key key}) : super(key: key);

  @override
  _CircularGraphicsPageState createState() => _CircularGraphicsPageState();
}

class _CircularGraphicsPageState extends State<CircularGraphicsPage> {
  double percentage= 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 CustomRadialProgress.gradient(
                  percentage: percentage, 
                  grandientCustomRadialProgress: LinearGradient(
                    colors: [
                      Color(0xffC012FF),
                      Color(0xff6D05E8),
                      Colors.red,
                    ],
                  ),
                ),
                CustomRadialProgress(percentage: percentage*1.2,colorCustomRadialProgress: Colors.orange,),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 CustomRadialProgress(percentage: percentage*1.4,colorCustomRadialProgress: Colors.purple,),
                 CustomRadialProgress.gradient(
                  percentage: percentage*1.6, 
                  grandientCustomRadialProgress:LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.black,
                    ],
                  ),
                )
               ],
             ),
           ],
         ),
       ),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.refresh),
         backgroundColor: Colors.pink,
         onPressed: (){
           setState(() {
             percentage += 10.0;
             if(percentage > 100.0){
               percentage = 0.0;
             }
           });
         },
       ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {

  final double percentage;
  final Color colorCustomRadialProgress;
  final Gradient grandientCustomRadialProgress;

  CustomRadialProgress({@required this.percentage,@required this.colorCustomRadialProgress, this.grandientCustomRadialProgress});
  CustomRadialProgress.gradient({@required this.percentage, this.colorCustomRadialProgress,@required this.grandientCustomRadialProgress});

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context).getCurrentTheme;

    return Container(
      width: 150.0,
      height: 150.0,
      child: RadialProgress(
        percentage: percentage,
        primaryColor: colorCustomRadialProgress,
        secondColor: themeChanger.textTheme.bodyText1.color,
        gradient: grandientCustomRadialProgress,
        circularWidth: 20.0,
        arcWidth: 20.0,
      ),
    );
  }
}