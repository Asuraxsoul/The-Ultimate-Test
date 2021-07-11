import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:the_ultimate_test/widgets/workout_card.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ReusableHeader.getAppBar("Workout Recommendations"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color(0xFFD7FFFE),
                Color(0xFFF5E6FA),
                Color(0xFFE3FDF5),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: WorkoutCard(
                  colorA: Colors.tealAccent,
                  colorB: Colors.lightBlue,
                  title: 'Workout Challenges',
                  description: 'Challenge your friends!',
                  longDescription:
                      '\nMany things in life are worth competing for!',
                  image: 'assets/images/challenge.PNG',
                  workoutCount: 8,
                  route: '/workoutChallenge',
                ),
              ),
              Expanded(
                flex: 1,
                child: WorkoutCard(
                  colorA: Colors.pink,
                  colorB: Colors.deepOrangeAccent,
                  title: 'Progression Workout',
                  description: 'Let\'s level up!',
                  longDescription:
                      '\nNever give up as even stagnation is temporary!',
                  image: 'assets/images/progression.jpg',
                  workoutCount: 3,
                  route: '/workoutProgression',
                ),
              ),
              Expanded(
                flex: 1,
                child: WorkoutCard(
                  colorA: Colors.indigoAccent,
                  colorB: basicColorPink,
                  title: 'Healthy Workout',
                  description: 'Keep fit and active!',
                  longDescription: '\nWhat contributes to a great lifestyle?',
                  image: 'assets/images/healthy.jpg',
                  workoutCount: 2,
                  route: '/workoutLifestyle',
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
