import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/route_generator.dart';

void main() {
  runApp(MyApp());
}

// Application Root
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Ultimate Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
