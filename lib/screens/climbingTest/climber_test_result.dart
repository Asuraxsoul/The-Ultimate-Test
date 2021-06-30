import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/utils/database.dart';
import 'package:the_ultimate_test/widgets/result_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClimberTestResultScreen extends StatefulWidget {
  final Results results;

  const ClimberTestResultScreen({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  _ClimberTestResultState createState() => _ClimberTestResultState();
}

int resultConverter(String result) {
  int convertedResult;
  if (result == "<100% (unable to hang)" ||
      result == "<10 seconds (Bent Knees)" ||
      result == "<30 seconds") {
    convertedResult = 0;
  } else if (result == "100%" ||
      result == "10 seconds (Bent Knees)" ||
      result == "30 seconds") {
    convertedResult = 1;
  } else if (result == "110%" ||
      result == "20 seconds (Bent Knees)" ||
      result == "1 minute") {
    convertedResult = 2;
  } else if (result == "120%" ||
      result == "30 seconds (Bent Knees)" ||
      result == "1 minute 30 seconds") {
    convertedResult = 3;
  } else if (result == "130%" ||
      result == "10 seconds (L-Sit)" ||
      result == "2 minutes") {
    convertedResult = 4;
  } else if (result == "140%" ||
      result == "15 seconds (L-Sit)" ||
      result == "2 minutes 30 seconds") {
    convertedResult = 5;
  } else if (result == "150%" ||
      result == "20 seconds (L-Sit)" ||
      result == "3 minutes") {
    convertedResult = 6;
  } else if (result == "160%" ||
      result == "5 seconds (Front Lever)" ||
      result == "3 minutes 30 seconds") {
    convertedResult = 7;
  } else if (result == "180%" ||
      result == "10 seconds (Front Lever)" ||
      result == "4 minutes") {
    convertedResult = 8;
  } else if (result == "200%" ||
      result == "20 seconds (Front Lever)" ||
      result == "5 minutes") {
    convertedResult = 9;
  } else if (result == "220%" ||
      result == "30 seconds (Front Lever)" ||
      result == "6 minutes") {
    convertedResult = 10;
  } else {
    convertedResult = 0;
  }

  return convertedResult;
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
                      scrollable: true,
                      backgroundColor: Colors.grey[700]!,
                      insetPadding: EdgeInsets.all(defaultPadding),
                      title: Text(
                        "The Strength You Need To Climb 9C:",
                        style: TextStyle(
                          fontSize: 26,
                          color: basicColorPink,
                          letterSpacing: 3.0,
                        ),
                      ),
                      content: Text(
                        "????????? - \n0.01%\n"
                        "40 = 9c/5.15d/V20\n"
                        "39 = 9b+/5.15c/V19\n"
                        "38 = 9b/5.15b/V19\n"
                        "37 = 9b/5.15b/V19\n"
                        "36 = 9a+/5.15a/V18\n"
                        "35 = 9a+/5.15a/V18\n"
                        "34 = 9a/5.14d/V17\n"
                        "33 = 9a/5.14d/V17\n"
                        "32 = 8c+/5.14c/V16\n"
                        "31 = 8c+/5.14c/V16\n"
                        "30 = 8c/5.14b/V15\n"
                        "29 = 8c/5.14b/V15\n\n"
                        "You are Insane - \nPRO\n"
                        "28 = 8b+/5.14a/V14\n"
                        "27 = 8b+/5.14a/V14\n"
                        "26 = 8b/5.13d/V13\n"
                        "25 = 8b/5.13d/V13\n"
                        "24 = 8a+/5.13c/V12\n"
                        "23 = 8a+/5.13c/V12\n"
                        "22 = 8a/5.13b/V11\n"
                        "21 = 8a/5.13b/V11\n\n"
                        "Master of the Craft - \nADVANCED\n"
                        "20 = 7c+/5.13a/V10\n"
                        "19 = 7c+/5.13a/V10\n"
                        "18 = 7c/5.12c/V9\n"
                        "17 = 7c/5.12c/V9\n"
                        "16 = 7b+/5.12b/V8\n"
                        "15 = 7b+/5.12b/V8\n"
                        "14 = 7b/5.12a/V8\n"
                        "13 = 7b/5.12a/V8\n"
                        "12 = 7a+/5.11d/V7\n"
                        "11 = 7a+/5.11d/V7\n\n"
                        "Keep It Up - \nINTERMEDIATE\n"
                        "10 = 7a/5.11c/V6\n"
                        "9 = 7a/5.11c/V6\n"
                        "8 = 6c+/5.11b/V5\n"
                        "7 = 6c+/5.11b/V5\n"
                        "6 = 6c/5.11a/V5\n"
                        "5 = 6c/5.11a/V5\n"
                        "4 = 6b+/5.10d/V4\n\n"
                        "Keep Going - \nBEGINNER\n"
                        "3 = 6b/5.10c/V3\n"
                        "2 = 6a+/5.10a/V3\n"
                        "1 = 6a/5.9/V3\n"
                        "0 = 5c/5.8/V2",
                        style: TextStyle(
                          fontSize: 24,
                          color: basicColorLBlue,
                          letterSpacing: 3.0,
                        ),
                        textAlign: TextAlign.left,
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
          decoration: BoxDecoration(color: Colors.white70),
          padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
              defaultPadding, defaultPadding * 2.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Results"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ResultCard(
                    title: "Finger Strength",
                    result: resultConverter(widget.results.result1),
                    total: 10,
                  ),
                  ResultCard(
                    title: "Pull Up Strength",
                    result: resultConverter(widget.results.result2),
                    total: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ResultCard(
                    title: "Core Strength",
                    result: resultConverter(widget.results.result3),
                    total: 10,
                  ),
                  ResultCard(
                    title: "Bar Hang Strength",
                    result: resultConverter(widget.results.result4),
                    total: 10,
                  ),
                ],
              ),
              Text(
                  "${resultConverter(widget.results.result1) + resultConverter(widget.results.result2) + resultConverter(widget.results.result3) + resultConverter(widget.results.result4)} / 40"),
              Container(
                height: 100,
                width: 100,
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Text(
                              '${(resultConverter(widget.results.result1) + resultConverter(widget.results.result2) + resultConverter(widget.results.result3) + resultConverter(widget.results.result4)) * 100 / 40}%',
                              style: TextStyle(fontSize: 11),
                            ))
                      ],
                      axisLineStyle: AxisLineStyle(
                        thickness: 0.1,
                        color: const Color.fromARGB(30, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[
                        RangePointer(
                            value: ((resultConverter(widget.results.result1) +
                                    resultConverter(widget.results.result2) +
                                    resultConverter(widget.results.result3) +
                                    resultConverter(widget.results.result4)) *
                                100 /
                                40),
                            width: 0.1,
                            sizeUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.startCurve,
                            gradient: const SweepGradient(colors: <Color>[
                              Color(0xFF00a9b5),
                              Color(0xFFa4edeb)
                            ], stops: <double>[
                              0.25,
                              0.75
                            ])),
                        MarkerPointer(
                          value: ((resultConverter(widget.results.result1) +
                                  resultConverter(widget.results.result2) +
                                  resultConverter(widget.results.result3) +
                                  resultConverter(widget.results.result4)) *
                              100 /
                              40),
                          markerType: MarkerType.circle,
                          color: const Color(0xFF87e8e8),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Text("Your Score"),
              Text(
                  "Click on the info icon at the top right to view your potential climbing grade"),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        backgroundColor: Colors.grey[700]!,
                        insetPadding: EdgeInsets.all(defaultPadding),
                        title: Text(
                          "Are you sure you want to Go Back?",
                          style: TextStyle(
                            fontSize: 26,
                            color: basicColorPink,
                            letterSpacing: 3.0,
                          ),
                        ),
                        content: Text(
                          "Your results will not be saved to your Achievements!",
                          style: TextStyle(
                            fontSize: 24,
                            color: basicColorLBlue,
                            letterSpacing: 3.0,
                          ),
                          textAlign: TextAlign.left,
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
                              Navigator.of(context)
                                  .pushReplacementNamed('/climberTest');
                            },
                          ),
                        ],
                      );
                    });
              },
              foregroundColor: Colors.black,
              icon: const Icon(Icons.arrow_back_ios_outlined),
              label: Text(
                'BACK\nI can do better',
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: basicColorTeal,
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                ConvertedResults cResults = new ConvertedResults();
                cResults.result1 = resultConverter(widget.results.result1);
                cResults.result2 = resultConverter(widget.results.result2);
                cResults.result3 = resultConverter(widget.results.result3);
                cResults.result4 = resultConverter(widget.results.result4);
                cResults.total = cResults.result1 +
                    cResults.result2 +
                    cResults.result3 +
                    cResults.result4;
                DatabaseService().addClimberTestResult(user, cResults);
                Navigator.of(context).pushReplacementNamed('/achievements');
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        backgroundColor: Colors.grey[700]!,
                        insetPadding: EdgeInsets.all(defaultPadding),
                        title: Text(
                          "Great work!",
                          style: TextStyle(
                            fontSize: 26,
                            color: basicColorPink,
                            letterSpacing: 3.0,
                          ),
                        ),
                        content: Text(
                          "Your results have been saved to your Achievements!",
                          style: TextStyle(
                            fontSize: 24,
                            color: basicColorLBlue,
                            letterSpacing: 3.0,
                          ),
                          textAlign: TextAlign.left,
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
              foregroundColor: Colors.black,
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: Text(
                'PROCEED\nI am satisfied',
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: basicColorTeal,
            ),
          ],
        ),
      ),
    );
  }
}
