import 'package:disenos/src/models/layout_model.dart';
import 'package:disenos/src/pages/launcher_page.dart';
import 'package:disenos/src/pages/launcher_tablet_page.dart';
import 'package:disenos/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeChanger>(create: (context) => new ThemeChanger(2),),
      ChangeNotifierProvider<LayoutModel>(create: (context) => new LayoutModel(),),
    ],
    child: MyApp()
  )
);

/*void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => new ThemeChanger(2),
    child: MyApp()
  )
);*/
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      theme: themeChanger.getCurrentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final screenSize = MediaQuery.of(context).size;

          if(screenSize.width > 500) {
            return LauncherTabletPage();
          }else{
            return LauncherPage();
          }
        },
      ),
    );
  }
}