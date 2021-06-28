import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'The Ultimate Climber Test',
          style: TextStyle(
            color: basicColorLBlue,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey[700]!,
                      insetPadding: EdgeInsets.all(defaultPadding),
                      title: Text(""),
                      content: Text(
                        "The Strength You Need To Climb 9C",
                        style: TextStyle(
                          fontSize: 26,
                          color: basicColorPink,
                          letterSpacing: 3.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: new Icon(
                            Icons.done,
                            color: basicColorLBlue,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.asset('assets/images/climbingTest.jpeg',
                    fit: BoxFit.fill),
              ),
              SizedBox(height: 30),
              Text(
                "Welcome to \nThe Ultimate Climber Test",
                style: TextStyle(fontSize: 24, color: basicColorBlue),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              InkWell(
                customBorder: CircleBorder(),
                splashColor: basicColorLBlue,
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[600]!),
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800]!,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/climberTestSlider');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
