import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/plan.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fishing Trip',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      routes: {
        '/plan': (context) => FishingPlanPage()
      },
    );
  }
}
