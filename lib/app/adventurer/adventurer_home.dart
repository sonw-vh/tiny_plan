import 'package:flutter/material.dart';
import 'package:tiny_plan/controllers/services/auth.dart';

class AdventurerHome extends StatefulWidget {
  const AdventurerHome({Key? key, this.auth}) : super(key: key);

  final AuthBase? auth;
  static Widget create(BuildContext context, AuthBase auth) {
    return AdventurerHome(auth: auth);
  }
  @override
  State<AdventurerHome> createState() => _AdventurerHomeState();
}

class _AdventurerHomeState extends State<AdventurerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Adventurer Home Screen'
        ),
      ),
    );
  }
}