import 'package:flutter/material.dart';
import 'package:sample_one/route_generator.dart';
import 'package:sample_one/src/resources/page_start.dart';
import 'package:sample_one/src/utils/colors.dart';
import 'package:sample_one/src/utils/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: tClear,
      theme: ThemeData(
          primarySwatch: orangeBackground,
          primaryColor: orangeBackground,
          accentColor: orangeBackground,
          canvasColor: white,
          focusColor: GREEN
      ),
      home: PageStart(),//App(currentPage: 0,),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


