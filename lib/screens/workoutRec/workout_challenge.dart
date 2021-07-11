import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';

class WorkoutChallengeScreen extends StatefulWidget {
  const WorkoutChallengeScreen({Key? key}) : super(key: key);

  @override
  _WorkoutChallengeScreenState createState() => _WorkoutChallengeScreenState();
}

class _WorkoutChallengeScreenState extends State<WorkoutChallengeScreen> {
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
          'Workout Progression',
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
                        "To be added",
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
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Give 8 example workout challenges here'),
              InkWell(
                onTap: () {},
                child: Text("To be made!"),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
