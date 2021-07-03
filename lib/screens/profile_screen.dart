import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_ultimate_test/utils/authentication.dart';
import 'package:the_ultimate_test/screens/sign_in_screen.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: ReusableHeader.getAppBar("Profile"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 50.0,
            top: 50.0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color(0xFFA6C1EE),
                Color(0xFFC9C2EB),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(),
                  _user.photoURL != null
                      ? ClipOval(
                          child: Material(
                            color: backgroundColor,
                            child: Image.network(
                              _user.photoURL!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            color: basicColorPink,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: tertiaryColor,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20.0),
                  Text(
                    'Hello,',
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_user.displayName!}',
                        style: TextStyle(
                          color: basicColorPurple,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        ' !',
                        style: TextStyle(
                          color: Colors.grey[600]!,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'you are signed in as',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '( ${_user.email!} )',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: basicColorGreen,
                      fontSize: 20,
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'To sign out of your account, click the "Sign Out"\nbutton below.',
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _isSigningOut
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              basicColorPink,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context)
                                .pushReplacement(_routeToSignInScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
