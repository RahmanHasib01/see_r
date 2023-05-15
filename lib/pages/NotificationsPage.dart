import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  void onButtonClicked() {
    // Add your button click logic here.
    print('Button clicked!');
    // You can replace the print statement with your desired action.
  }

  void search() {
    // Add your button click logic here.
    print('Button clicked!');
    // You can replace the print statement with your desired action.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 240, 234, 210),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            child: GNav(
              backgroundColor: Color.fromARGB(255, 240, 234, 210),
              color: Color.fromARGB(155, 100, 56, 1),
              tabBackgroundColor: Color.fromARGB(35, 100, 55, 1),
              padding: EdgeInsets.all(10),
              tabs: [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(
                    icon: Icons.notifications_rounded, text: 'Notifications'),
                GButton(icon: Icons.play_circle, text: 'Playback'),
                GButton(icon: Icons.more, text: ' More'),
              ],
            ),
          ),
        ),
        // Bottom Navigation Bar

        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Search.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Content above the button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding:
                          const EdgeInsets.only(left: 165, top: 10, bottom: 0),
                      child: const Text(
                        'HOME',
                        style: TextStyle(
                          fontFamily: 'opensans',
                          fontSize: 12,
                          color: Color.fromARGB(255, 100, 79, 56),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(left: 150, bottom: 0),
                      child: GestureDetector(
                        onTap: search, // Call the button click handler
                        child: const SizedBox(
                          width: 18,
                          height: 18,
                          child: Icon(
                            Icons.search,
                            size: 20,
                            color: Color.fromARGB(255, 100, 79, 56),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Padding(padding: EdgeInsets.only(bottom: 250)),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Connect a camera to see if any wanted guests are in ',
                    style: TextStyle(
                        fontFamily: 'opensans',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 100, 79, 56)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: const Text(
                    'your property',
                    style: TextStyle(
                        fontFamily: 'opensans',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 100, 79, 56)),
                  ),
                ),
                // Button
                Align(
                  alignment: const Alignment(0,
                      0.1), // Adjust the y-axis value to move the button up or down
                  child: GestureDetector(
                    onTap: onButtonClicked, // Call the button click handler
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 100, 79, 56),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Content below the button
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Add devices',
                    style: TextStyle(
                        fontFamily: 'MyCustomFont',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 100, 79, 56)),
                  ),
                ),
              ],
            ),
          ),
          // body
        ),
      ),
    );
  }
}
