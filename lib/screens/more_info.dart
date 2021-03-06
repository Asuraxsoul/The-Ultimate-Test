import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

Future<void> _launchURL(String url) async {
  String urL = 'https://github.com/Asuraxsoul/The-Ultimate-Test';
  if (await canLaunch(urL)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Unable to launch $url';
  }
}

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ReusableHeader.getAppBar("About Us"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: defaultPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color(0xFFACCBFF),
                Color(0xFFE7F5FF),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inspiration - How did this app come about?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This idea was sparked by one of Magnus Midtb??\'s YouTube video "The strength you need to climb 9C".',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Color(0xCC187BCD),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purpose - What is this app trying to achieve?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This app serves to not only further my personal understanding on app development '
                      'but also encourage people to set and maintain fitness goals sustainably.',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Color(0xFF2A9DF4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'To view source code, visit:  ',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.8,
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Colors.grey[700]!.withOpacity(0.8),
                                      insetPadding:
                                          EdgeInsets.all(defaultPadding),
                                      title: Text(
                                        "Visit Asuraxsoul Github Repo?",
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                      content: Text(
                                        'Redirecting you to view source code for The-Ultimate-Test app!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: new Icon(
                                            Icons.close,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: new Icon(
                                            Icons.done,
                                            color: Colors.lightBlueAccent,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            _launchURL(
                                                "https://github.com/Asuraxsoul/The-Ultimate-Test");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              child: Text(
                                'Asuraxsoul Github',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent[100]!,
                                  fontSize: 17,
                                  letterSpacing: 0.8,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('https://github.com/Asuraxsoul/The-Ultimate-Test',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Color(0xDD03254C),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reach Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This project is likely to be a one-off event.\n'
                      'If you are interested in contributing or collaborating, please contact this email:',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'viscountlapiz@gmail.com',
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 1,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
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
