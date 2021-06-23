import 'package:flutter/material.dart';
import 'package:the_ultimate_test/screens/sign_in_screen.dart';

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
      home: SignInScreen(),
    );
  }
}
