import 'package:disenos/src/routes/routes.dart';
import 'package:disenos/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context).getCurrentTheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Diseños en flutter - Teléfono')),
        backgroundColor: themeChanger.accentColor,
      ),
      drawer: _MainMenu(),
      body: _OptionList(),
    );
  }
}

class _MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Drawer(
      child: Container(
        //color: Colors.pink,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                height: 100.0,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: themeChanger.getCurrentTheme.accentColor,
                  child: Text('FH',style: TextStyle(fontSize: 50.0),),
                ),
              ),
            ),
            Expanded(child: _OptionList(),),
            ListTile(
              leading: Icon(Icons.lightbulb_outline,color: themeChanger.getCurrentTheme.accentColor,),
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: themeChanger.getDarkTheme,
                activeColor: themeChanger.getCurrentTheme.accentColor, 
                onChanged: (value)=>themeChanger.setDarkTheme = value,
              ),
            ),
            SafeArea(
              bottom: true,
              top: false,
              right: false,
              left: false,
              child: ListTile(
                leading: Icon(Icons.add_to_home_screen,color: themeChanger.getCurrentTheme.accentColor,),
                title: Text('Custom Theme'),
                trailing: Switch.adaptive(
                  value: themeChanger.getCustomTheme,
                  activeColor: themeChanger.getCurrentTheme.accentColor, 
                  onChanged: (value)=>themeChanger.setCustomTheme = value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context,i) => Divider(
        color: themeChanger.getCurrentTheme.primaryColorLight,
      ), 
      itemCount: pageRoutes.length,
      itemBuilder: (context,i)=> ListTile(
        leading: FaIcon(pageRoutes[i].icon,color: themeChanger.getCurrentTheme.accentColor,),
        title: Text(pageRoutes[i].title),
        trailing: Icon(Icons.chevron_right,color:themeChanger.getCurrentTheme.accentColor,),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> pageRoutes[i].page));
        },
      ),
    );
  }
}