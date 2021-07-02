import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_ultimate_test/utils/constants.dart';

String rankResult(int total) {
  if (total <= 3) {
    return 'BEGINNER';
  } else if (total <= 10) {
    return 'INTERMEDIATE';
  } else if (total <= 20) {
    return 'ADVANCED';
  } else if (total <= 28) {
    return 'PRO';
  } else if (total <= 40) {
    return 'TOP 0.01%';
  } else {
    return 'BEGINNER';
  }
}

String rankPic(String rank) {
  if (rank == 'TOP 0.01%') {
    return 'assets/icons/top.svg';
  } else if (rank == 'PRO') {
    return 'assets/icons/pro.svg';
  } else if (rank == 'ADVANCED') {
    return 'assets/icons/advanced.svg';
  } else if (rank == 'INTERMEDIATE') {
    return 'assets/icons/intermediate.svg';
  } else {
    return 'assets/icons/beginner.svg';
  }
}

class AchievementResultCard extends StatefulWidget {
  final String tag;
  final int fingerStrength;
  final int pullUp;
  final int coreTime;
  final int hangTime;
  final String dateTime;

  const AchievementResultCard({
    Key? key,
    required this.tag,
    required this.fingerStrength,
    required this.pullUp,
    required this.coreTime,
    required this.hangTime,
    required this.dateTime,
  }) : super(key: key);

  @override
  _AchievementResultCardState createState() => _AchievementResultCardState();
}

class _AchievementResultCardState extends State<AchievementResultCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                defaultPadding, defaultPadding * 3),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 90,
                        child: Text(
                          '${widget.dateTime}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Hero(
                      tag: '${widget.tag}',
                      child: SvgPicture.asset(
                        rankPic(rankResult(widget.fingerStrength +
                            widget.pullUp +
                            widget.coreTime +
                            widget.hangTime)),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${rankResult(widget.fingerStrength + widget.pullUp + widget.coreTime + widget.hangTime)} Climber',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Finger Strength:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.fingerStrength}/10',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pull Up Strength:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.pullUp}/10',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Core Strength:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.coreTime}/10',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bar Hang Strength:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.hangTime}/10',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Total Score',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.fingerStrength + widget.pullUp + widget.coreTime + widget.hangTime} / 40',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                ElevatedButton(
                  child: Text('Back to Achievements!'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;

  CustomPageRoute(this.child);

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(seconds: 1);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
