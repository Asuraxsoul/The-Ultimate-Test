import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                    "View this project's details @ ..., add how this project get started and purpose"),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
