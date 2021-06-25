import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';

class ClimberTestScreen extends StatefulWidget {
  const ClimberTestScreen({Key? key}) : super(key: key);

  @override
  _ClimberTestScreenState createState() => _ClimberTestScreenState();
}

class _ClimberTestScreenState extends State<ClimberTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('The Ultimate Climber Test'),
        backgroundColor: basicColorLBlue,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text("Welcome to The Ultimate Climber Test"),
            ],
          ),
        ),
      ),
    );
  }
}
