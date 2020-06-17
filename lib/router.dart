

import 'package:Result8/homepage.dart';
import 'package:Result8/nagarpalikaselect.dart';
import 'package:Result8/result.dart';
import 'package:Result8/selector.dart';
import 'package:Result8/splash.dart';
import 'package:flutter/material.dart';

Route<dynamic> generatedRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case "nagarpalika":
      return MaterialPageRoute(builder: (context) => Nagarpalika());
    case "selector":
      return MaterialPageRoute(
          builder: (context) => Selector(
                id: settings.arguments,
              ));
    case "homepage":
      return MaterialPageRoute(
          builder: (context) => HomePage(
                isshow: settings.arguments,
              ));
    case "result":
      return MaterialPageRoute(
          builder: (context) => MyHomePage(
                student: settings.arguments,
              ));

    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
