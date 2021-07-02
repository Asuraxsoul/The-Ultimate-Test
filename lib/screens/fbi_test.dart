import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';

class FbiTestScreen extends StatefulWidget {
  const FbiTestScreen({Key? key}) : super(key: key);

  @override
  _FbiTestScreenState createState() => _FbiTestScreenState();
}

class _FbiTestScreenState extends State<FbiTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('The Ultimate FBI Test'),
        backgroundColor: basicColorLBlue,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              Text(
                "Welcome to The Ultimate Climber Test",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "COMING SOON!",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
