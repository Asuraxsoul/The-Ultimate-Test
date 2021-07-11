import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_ultimate_test/screens/splash_screen.dart';
import 'package:the_ultimate_test/screens/sign_in_screen.dart';
import 'package:the_ultimate_test/screens/profile_screen.dart';
import 'package:the_ultimate_test/screens/test.dart';
import 'package:the_ultimate_test/screens/climbingTest/climber_test.dart';
import 'package:the_ultimate_test/screens/climbingTest/climber_test_slider.dart';
import 'package:the_ultimate_test/screens/climbingTest/climber_test_result.dart';
import 'package:the_ultimate_test/screens/fbi_test.dart';
import 'package:the_ultimate_test/screens/achievements.dart';
import 'package:the_ultimate_test/screens/more_info.dart';
import 'package:the_ultimate_test/screens/workoutRec/help.dart';
import 'package:the_ultimate_test/screens/settings.dart';
import 'package:the_ultimate_test/widgets/result_card.dart';
import 'package:the_ultimate_test/screens/workoutRec/workout_progression.dart';
import 'package:the_ultimate_test/screens/workoutRec/workout_challenge.dart';
import 'package:the_ultimate_test/screens/workoutRec/workout_lifestyle.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case '/profile':
        final paramUser = args as User;
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            user: paramUser,
          ),
        );

      case '/test':
        return MaterialPageRoute(builder: (_) => TestScreen());

      case '/climberTest':
        return MaterialPageRoute(builder: (_) => ClimberTestScreen());

      case '/climberTestSlider':
        return MaterialPageRoute(builder: (_) => ClimberTestSliderScreen());

      case '/climberTestResult':
        final results = args as Results;
        return MaterialPageRoute(
          builder: (_) => ClimberTestResultScreen(
            results: results,
          ),
        );

      case '/fbiTest':
        return MaterialPageRoute(builder: (_) => FbiTestScreen());

      case '/achievements':
        return MaterialPageRoute(builder: (_) => AchievementsScreen());

      case '/aboutUs':
        return MaterialPageRoute(builder: (_) => AboutUsScreen());

      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case '/help':
        return MaterialPageRoute(builder: (_) => HelpScreen());

      case '/workoutProgression':
        return MaterialPageRoute(builder: (_) => WorkoutProgressionScreen());

      case '/workoutChallenge':
        return MaterialPageRoute(builder: (_) => WorkoutChallengeScreen());

      case '/workoutLifestyle':
        return MaterialPageRoute(builder: (_) => WorkoutLifestyleScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Text('ERROR: Page not found!'),
        ),
      );
    });
  }
}
