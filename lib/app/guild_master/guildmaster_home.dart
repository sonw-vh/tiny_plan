import 'package:flutter/material.dart';
import 'package:tiny_plan/services/auth.dart';

class GuildMasterHome extends StatefulWidget {
  const GuildMasterHome({Key? key, this.auth}) : super(key: key);

  final AuthBase? auth;
  static Widget create(BuildContext context, AuthBase auth) {
    return GuildMasterHome(auth: auth);
  }
  @override
  State<GuildMasterHome> createState() => _GuildMasterHomeState();
}

class _GuildMasterHomeState extends State<GuildMasterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Guild Master Home Screen'
        ),
      ),
    );
  }
}