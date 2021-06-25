import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ReusableHeader.getAppBar("Challenge yourself"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/climberTest');
                },
                child: Text("The Ultimate Climber Test"),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/fbiTest');
                },
                child: Text("The Ultimate FBI Test"),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
