import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tiny_plan/theme/theme.dart';

class AdventurerBottomNavBar extends StatefulWidget {

  @override
  State<AdventurerBottomNavBar> createState() => _AdventurerBottomNavBarState();
}

class _AdventurerBottomNavBarState extends State<AdventurerBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: ThemeColor.shadow,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade700,
            color: Colors.white,
            gap: 8,
            padding: EdgeInsets.all(16),

            onTabChange: (value) {
              print(value);
            },
            tabs: [
              GButton(
                icon: Icons.gamepad_outlined,
                text: 'Game',
              ),
              
              GButton(
                icon: Icons.map,
                text: 'Dungeon Map',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ]
          ),
        ),
      ),
    );
  }
}