import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:flutter/services.dart';

class ClimberTestResultScreen extends StatefulWidget {
  const ClimberTestResultScreen({Key? key}) : super(key: key);

  @override
  _ClimberTestResultState createState() => _ClimberTestResultState();
}

class _ClimberTestResultState extends State<ClimberTestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
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
                      title: Text("The Strength You Need To Climb 9C: \n"),
                      content: Text(
                        "",
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
          child: Center(
            child: Text("Results"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/achievements');
        },
        child: const Icon(Icons.arrow_forward_ios_outlined),
        backgroundColor: basicColorTeal,
      ),
    );
  }
}
