import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/authentication.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/google_sign_in_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: SvgPicture.asset(
                        'assets/icons/strong.svg',
                        width: 160,
                        height: 160,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The ',
                          style: TextStyle(
                            color: basicColorTeal,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Ultimate ',
                          style: TextStyle(
                            color: basicColorPink,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Test',
                          style: TextStyle(
                            color: basicColorTeal,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Do you dare to take up the challenge?",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      basicColorLBlue,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
