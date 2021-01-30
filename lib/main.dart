import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:conexionsur/services/theme_changer.dart';
import 'package:conexionsur/theme.dart';
import 'package:conexionsur/pages/home.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: Builder(builder: (context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: TITLE,
          themeMode: themeChanger.getTheme,
          darkTheme: Style.get(true),
          theme: Style.get(false),
          home: HomePage(),
        );
      }),
    );
  }
}