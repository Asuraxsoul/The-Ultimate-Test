import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBAE3FF),
      appBar: ReusableHeader.getAppBar("Challenge yourself"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: basicColorBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/climberTest');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: Color(0xFF44CCFF), width: 3),
                  ),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        "The Ultimate Climber Test",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      SvgPicture.asset(
                        'assets/icons/climbing.svg',
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/fbiTest');
                },
                splashColor: basicColorGreen,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: basicColorTeal, width: 3),
                  ),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        "The Ultimate FBI Test",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      SvgPicture.asset(
                        'assets/icons/fbi.svg',
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
