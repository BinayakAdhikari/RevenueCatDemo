import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:revenue_cat_demo/src/models/styles.dart';

import 'views/home.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        barBackgroundColor: kColorBar,
        primaryColor: kColorText,
        textTheme: CupertinoTextThemeData(
          primaryColor: kColorText,
        ),
      ),
      home: AppContainer(),
    );
  }
}