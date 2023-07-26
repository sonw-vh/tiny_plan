import 'package:flutter/material.dart';
import 'package:tiny_plan/app/landing_screen.dart';
import 'package:tiny_plan/app/splash/splash_screen.dart';
import 'package:tiny_plan/controllers/services/shared_preferences.dart';

// ignore: must_be_immutable
class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  bool? _isVisited;

  ///_setFlagValue for the user when he entered the app
  ///To Display a Splash Screen
  Future<void> _setFlagValue() async {
    var isVisited = await SharedPreference().getVisitingFlag();
    setState(() {
      _isVisited = isVisited;
    });
  }

  @override
  void initState() {
    _setFlagValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_isVisited) {
      case true:
        return LandingScreen();
      case false:
        return SplashScreen();
      default:
        return CircularProgressIndicator();
    }
  }
}
