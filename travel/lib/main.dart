import 'package:flutter/material.dart';
import 'package:travel/model/content.dart';
import 'intro.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Content(),
      child:
          const MaterialApp(debugShowCheckedModeBanner: false, home: Intro()),
    );
  }
}
