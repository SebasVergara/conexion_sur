import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:conexionsur/services/theme_changer.dart';
import 'package:conexionsur/theme.dart';
import 'package:conexionsur/pages/home.dart';
import 'package:conexionsur/pages/news.dart';
import 'package:conexionsur/services/api.dart';

import 'constants.dart';
import 'models/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.init(
      "232fc69d-a457-4f79-8676-835f81c431e5",
    );
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    FirebaseAnalytics analytics = FirebaseAnalytics();

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
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        );
      }),
    );
  }
}
