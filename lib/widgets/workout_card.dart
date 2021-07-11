import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_ultimate_test/widgets/customised_button.dart';
import 'package:the_ultimate_test/utils/constants.dart';

class WorkoutCard extends StatefulWidget {
  final Color colorA;
  final Color colorB;
  final String title;
  final String description;
  final String longDescription;
  final String image;
  final int workoutCount;
  final String route;

  const WorkoutCard({
    Key? key,
    required this.colorA,
    required this.colorB,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.image,
    required this.workoutCount,
    required this.route,
  }) : super(key: key);

  @override
  _WorkoutCardState createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.colorA,
            widget.colorB,
          ],
        ),
        image: DecorationImage(
          image: AssetImage(widget.image),
          fit: BoxFit.fitWidth,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.dstATop),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTapUp: (val) {
                      setState(() {
                        isPressed = false;
                      });
                    },
                    onTapDown: (val) {
                      setState(() {
                        isPressed = true;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        isPressed = false;
                      });
                    },
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[700]!,
                              insetPadding: EdgeInsets.all(16),
                              title: Text(
                                widget.longDescription,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: new Icon(
                                    Icons.done,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPressed ? Colors.grey : Colors.white,
                      ),
                      child: Icon(
                        Icons.waves,
                        color: widget.colorA,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${widget.workoutCount} workouts available!',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              CustomisedButton(
                colorA: widget.colorB,
                colorB: widget.colorA,
                route: widget.route,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Text(""),
        ],
      ),
    );
  }
}
