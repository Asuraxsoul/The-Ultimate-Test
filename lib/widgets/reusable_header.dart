import 'package:flutter/material.dart';
import 'package:the_ultimate_test/widgets/custom_list_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReusableHeader {
  static getAppBar(String title) {
    return AppBar(
      elevation: 5.0,
      title: Text(title),
      centerTitle: true,
      backgroundColor: basicColorBlue,
    );
  }

  static getDrawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[basicColorBlue, basicColorTeal]),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/shoes.svg',
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The Ultimate Test',
                      style: TextStyle(color: basicColorPink, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomListTile(
            Icons.person,
            'Profile',
            () {
              User? user = FirebaseAuth.instance.currentUser;
              Navigator.of(context).pushNamed('/profile', arguments: user);
            },
          ),
          CustomListTile(
            Icons.accessibility,
            'Take a Test',
            () {
              Navigator.of(context).pushNamed('/test');
            },
          ),
          CustomListTile(
            Icons.stars,
            'Achievements',
            () {
              Navigator.of(context).pushNamed('/achievements');
            },
          ),
          CustomListTile(
            Icons.settings,
            'Settings',
            () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
          CustomListTile(
            Icons.info_outline,
            'About Us',
            () {
              Navigator.of(context).pushNamed('/aboutUs');
            },
          ),
          CustomListTile(
            Icons.help_outline,
            'Help',
            () {
              Navigator.of(context).pushNamed('/help');
            },
          ),
          SizedBox(
            height: 0.15 * mediaHeight(context),
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Text("Quote of the Day here"),
          ),
        ],
      ),
    );
  }
}
