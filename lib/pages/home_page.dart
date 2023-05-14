import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: const GNav(
          backgroundColor: Color.fromARGB(255, 240, 234, 210),
          color: Color.fromARGB(255, 100, 56, 1),
          gap: 5,
          tabs: [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.notifications_rounded, text: 'Notifications'),
            GButton(icon: Icons.play_circle, text: 'Playback'),
            GButton(icon: Icons.more, text: 'More'),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
