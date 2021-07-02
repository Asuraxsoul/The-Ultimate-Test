import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:the_ultimate_test/widgets/result_card.dart';

Shader linearGradient(Color colorA, Color colorB) {
  return LinearGradient(
    colors: <Color>[colorA, colorB],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300, 0.0));
}

class ClimberTestSliderScreen extends StatefulWidget {
  const ClimberTestSliderScreen({Key? key}) : super(key: key);

  @override
  ClimberTestSliderScreenState createState() =>
      new ClimberTestSliderScreenState();
}

class ClimberTestSliderScreenState extends State<ClimberTestSliderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  List<Slide> slides = [];
  String? currentSelectedValueEx1;
  String? currentSelectedValueEx2;
  String? currentSelectedValueEx3;
  String? currentSelectedValueEx4;
  var options = [
    "<100% (unable to hang)",
    "100%",
    "110%",
    "120%",
    "130%",
    "140%",
    "150%",
    "160%",
    "180%",
    "200%",
    "220%"
  ];
  var optionsEx3 = [
    "<10 seconds (Bent Knees)",
    "10 seconds (Bent Knees)",
    "20 seconds (Bent Knees)",
    "30 seconds (Bent Knees)",
    "10 seconds (L-Sit)",
    "15 seconds (L-Sit)",
    "20 seconds (L-Sit)",
    "5 seconds (Front Lever)",
    "10 seconds (Front Lever)",
    "20 seconds (Front Lever)",
    "30 seconds (Front Lever)"
  ];
  var optionsEx4 = [
    "<30 seconds",
    "30 seconds",
    "1 minute",
    "1 minute 30 seconds",
    "2 minutes",
    "2 minutes 30 seconds",
    "3 minutes",
    "3 minutes 30 seconds",
    "4 minutes",
    "5 minutes",
    "6 minutes"
  ];

  // 5 seconds countdown
  int _counter = 5;
  late Timer _timer;

  void _startTimer() {
    controller
      ..reset()
      ..forward();
    setState(() {
      _counter = 5;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 1) {
        controller
          ..reset()
          ..forward();
        setState(() {
          _counter--;
        });
      } else if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          _timer.cancel();
        });
      }
    });
  }

  // Stopwatch
  int _counterUp = 0;
  bool _isStopped = false;
  late Timer _timerUp;

  void _startStopWatch() {
    setState(() {
      _counterUp = 0;
      _isStopped = false;
    });

    _timerUp = Timer.periodic(Duration(seconds: 1), (timerUp) {
      setState(() {
        if (_counterUp >= 0 && !_isStopped) {
          _counterUp++;
        } else {
          _timerUp.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    ).drive(Tween(begin: 0, end: 1));

    // Starting Slide
    slides.add(
      new Slide(
        backgroundImage: "assets/images/climbTestStart.png",
        backgroundColor: Colors.grey[600]!,
        title: "The Ultimate Climber Test",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "The 4 exercises are in order:\n\n- Maximum Finger Strength\n"
            "(20mm crimp 5 seconds hang) [%bodyweight]\n\n"
            "- Maximum Pull-Up Strength\n"
            "(One rep) [%bodyweight]\n\n"
            "- Maximum Core Strength\n"
            "(Bent-knees/L-sit/FrontLever) [longest time]\n\n"
            "- Maximum Bar Hang Strength\n"
            "(No re-adjustment) [longest time]",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        centerWidget: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Text(
            "This test consists of 4 exercises that records your physical strength and gauges your maximum climbing grade.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
        //backgroundImage: 'assets/icons/blob_blue.svg',
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );

    //Exercise 1
    slides.add(
      new Slide(
        title: "Exercise 1: Finger Strength",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            foreground: Paint()
              ..shader = linearGradient(Colors.red[900]!, basicColorRed),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Goal: Hold a 5 SECONDS crimp on a 20mm edge with as much %bodyweight as you can\n\n"
            "Minimum: 100% bodyweight\n"
            "Maximum: 220% bodyweight",
        styleDescription: TextStyle(
          foreground: Paint()
            ..shader = linearGradient(basicColorRed, Colors.red[700]!),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
        backgroundImage: "assets/images/ex1gradient.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 6,
        centerWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Image.asset(
                'assets/images/fingerStrength.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
              ),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Body Weight %",
                    fillColor: Colors.white70,
                    filled: true,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Please select an option'),
                      value: currentSelectedValueEx1,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValueEx1 = newValue;
                        });
                      },
                      items: options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: defaultPadding),
            Container(
              child: Builder(builder: (counter) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(defaultPadding * 3.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.yellowAccent.withOpacity(0.3)),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(defaultPadding * 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.yellowAccent.withOpacity(0.3)),
                              color: Colors.white70.withOpacity(0.7),
                            ),
                            child: Text(
                              '$_counter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          RotationTransition(
                            turns: animation,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 5.0,
                                width: 5.0,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, -50),
                                      ),
                                      BoxShadow(
                                        color: Colors.yellow[300]!,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, -50),
                                      ),
                                      BoxShadow(
                                        color: Colors.yellow[300]!,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, -50),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.3),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              onTap:
                                  (_counter == 5) ? () => _startTimer() : () {},
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: basicColorPurple.withOpacity(0.7)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: (_counter == 0)
                                    ? Text(
                                        "Done!",
                                        style: TextStyle(
                                          color: basicColorGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      )
                                    : (_counter == 5)
                                        ? Text(
                                            "Start!",
                                            style: TextStyle(
                                              color: basicColorRed,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          )
                                        : Text(
                                            "Hang...",
                                            style: TextStyle(
                                              color: basicColorBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                          SizedBox(width: defaultPadding),
                          TextButton(
                            child: Text(
                              "reset",
                              style: TextStyle(
                                color: basicColorTeal,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _counter = 5;
                                _timer.cancel();
                              });
                            },
                          ),
                        ],
                      ),
                    ]);
              }),
            ),
          ],
        ),
      ),
    );

    //Exercise 2
    slides.add(
      new Slide(
        title: "Exercise 2: Pull-up Strength",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            foreground: Paint()
              ..shader = linearGradient(Color(0xffFFDAB9), basicColorYellow),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Goal: Do one proper pull-up (no kipping) with as much %bodyweight as you can\n\n"
            "Minimum: 100% bodyweight\n"
            "Maximum: 220% bodyweight",
        styleDescription: TextStyle(
          foreground: Paint()
            ..shader = linearGradient(basicColorYellow, Color(0xffFFDAB9)),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
        backgroundImage: "assets/images/ex2gradient.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 6,
        centerWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.all(defaultPadding),
              child: Image.asset(
                'assets/images/pullUp.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
              ),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Body Weight %",
                    fillColor: Colors.white70,
                    filled: true,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Please select an option'),
                      value: currentSelectedValueEx2,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValueEx2 = newValue;
                        });
                      },
                      items: options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );

    //Exercise 3
    slides.add(
      new Slide(
        title: "Exercise 3: Core Strength",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            foreground: Paint()
              ..shader = linearGradient(Colors.indigo, Color(0xff8921aa)),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Goal: Hold a core dependent position (Bent Knee/ L-Sit/ Front Lever) for as long as you can\n\n"
            "Minimum: 10 seconds Knee-bent L-sit\n"
            "Maximum: 30 seconds Front Lever",
        styleDescription: TextStyle(
          foreground: Paint()
            ..shader = linearGradient(Color(0xff8921aa), Colors.indigo),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
        ),
        backgroundImage: "assets/images/ex3gradient.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 6,
        centerWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Image.asset(
                'assets/images/coreTime.PNG',
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
              ),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Hang Time",
                    fillColor: Colors.white70,
                    filled: true,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Please select an option'),
                      value: currentSelectedValueEx3,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValueEx3 = newValue;
                        });
                      },
                      items: optionsEx3.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: defaultPadding),
            Container(
              child: Builder(builder: (counter) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding * 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!),
                          color: Colors.white70.withOpacity(0.7),
                        ),
                        child: Text(
                          '$_counterUp',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.3),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              onTap: (_counterUp == 0)
                                  ? () => _startStopWatch()
                                  : () {
                                      setState(() {
                                        _isStopped = true;
                                        _timerUp.cancel();
                                      });
                                    },
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: basicColorPurple.withOpacity(0.7)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: (_counterUp != 0)
                                    ? Text(
                                        "Stop",
                                        style: TextStyle(
                                          color: basicColorGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      )
                                    : Text(
                                        "Start!",
                                        style: TextStyle(
                                          color: basicColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: defaultPadding),
                          TextButton(
                            child: Text(
                              "reset",
                              style: TextStyle(
                                color: basicColorTeal,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _counterUp = 0;
                                _isStopped = true;
                                _timerUp.cancel();
                              });
                            },
                          ),
                        ],
                      ),
                    ]);
              }),
            ),
          ],
        ),
      ),
    );

    //Exercise 4
    slides.add(
      new Slide(
        title: "Exercise 4: Bar Hang Strength",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            foreground: Paint()
              ..shader = linearGradient(basicColorLBlue, basicColorTeal),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Goal: Hang on a bar (no readjusting grip) as long as you can\n\n"
            "Minimum: 30 seconds\n"
            "Maximum: 6 minutes",
        styleDescription: TextStyle(
          foreground: Paint()
            ..shader = linearGradient(basicColorTeal, basicColorLBlue),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
        ),
        backgroundImage: "assets/images/ex4gradient.png",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 6,
        centerWidget: Column(
          children: [
            Container(
              margin: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Image.asset(
                'assets/images/hangTime.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
              ),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Hang Time",
                    fillColor: Colors.white70,
                    filled: true,
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Please select an option'),
                      value: currentSelectedValueEx4,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValueEx4 = newValue;
                        });
                      },
                      items: optionsEx4.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: defaultPadding),
            Container(
              child: Builder(builder: (counter) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding * 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!),
                          color: Colors.white70.withOpacity(0.7),
                        ),
                        child: Text(
                          '$_counterUp',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.3),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              onTap: (_counterUp == 0)
                                  ? () => _startStopWatch()
                                  : () {
                                      setState(() {
                                        _isStopped = true;
                                        _timerUp.cancel();
                                      });
                                    },
                              child: Container(
                                padding: EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: basicColorPurple.withOpacity(0.7)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: (_counterUp != 0)
                                    ? Text(
                                        "Stop",
                                        style: TextStyle(
                                          color: basicColorGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      )
                                    : Text(
                                        "Start!",
                                        style: TextStyle(
                                          color: basicColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: defaultPadding),
                          TextButton(
                            child: Text(
                              "reset",
                              style: TextStyle(
                                color: basicColorTeal,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _counterUp = 0;
                                _isStopped = true;
                                _timerUp.cancel();
                              });
                            },
                          ),
                        ],
                      ),
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    controller.dispose();
    super.dispose();
  }

  void onDonePress() {
    // Navigate to next page if all results are filled in
    if (currentSelectedValueEx1 != null &&
        currentSelectedValueEx2 != null &&
        currentSelectedValueEx3 != null &&
        currentSelectedValueEx3 != null) {
      Results results = new Results();
      results.result1 = currentSelectedValueEx1 as String;
      results.result2 = currentSelectedValueEx2 as String;
      results.result3 = currentSelectedValueEx3 as String;
      results.result4 = currentSelectedValueEx4 as String;
      Navigator.of(context)
          .pushReplacementNamed('/climberTestResult', arguments: results);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey[700]!,
              insetPadding: EdgeInsets.all(defaultPadding),
              title: Text(""),
              content: Text(
                "Oops! Did you miss out any exercises?",
                style: TextStyle(
                  fontSize: 26,
                  color: basicColorTeal,
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
    }
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: basicColorTeal,
      size: 35.0,
    );
  }

  Widget renderPrevBtn() {
    return Icon(
      Icons.navigate_before,
      color: Color(0xffF3B4BA),
      size: 35.0,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
    );
  }

  ButtonStyle myDoneButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33A2E8D8)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x719990)),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      showSkipBtn: false,

      // Prev button
      renderPrevBtn: this.renderPrevBtn(),
      prevButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myDoneButtonStyle(),

      // Dot indicator
      colorDot: Color(0x33FFA8B0),
      colorActiveDot: Color(0xffFFA8B0),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
