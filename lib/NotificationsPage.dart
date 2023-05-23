import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

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

class _NotificationsPageState extends State<NotificationsPage> {
  int _currentIndex = 1;

  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      // Navigate to the corresponding page based on the index
      switch (_currentIndex) {
        case 0:
          // Navigate to the Home Page
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          // Navigate to the Notifications Page
          Navigator.pushNamed(context, '/notifications');
          break;
        case 2:
          // Navigate to the Playback Page
          Navigator.pushNamed(context, '/playback');
          break;
        case 3:
          // Navigate to the More Page
          Navigator.pushNamed(context, '/more');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 240, 234, 210),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 240, 234, 210),
            color: const Color.fromARGB(155, 100, 56, 1),
            activeColor: const Color.fromARGB(255, 154, 178, 87),
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.notifications_rounded, text: 'Notifications'),
              GButton(icon: Icons.play_circle, text: 'Playback'),
              GButton(icon: Icons.more, text: ' More'),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              _onTabSelected(index);
            },
          ),
        ),
      ),
      // Bottom Navigation Bar

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgimage.jpg'),
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
                        const EdgeInsets.only(left: 145, top: 10, bottom: 0),
                    child: const Text(
                      'NOTIFICATIONS',
                      style: TextStyle(
                        fontFamily: 'opensans',
                        fontSize: 12,
                        color: Color.fromARGB(255, 100, 79, 56),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(left: 120, bottom: 0),
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
                  'Unwanted guests are welcomed and listed here ',
                  style: TextStyle(
                      fontFamily: 'opensans',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 100, 79, 56)),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: const Text(
                  'along with some wanted notifications.',
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
                      color: Color.fromARGB(125, 100, 79, 56),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.messages_14,
                      size: 40,
                      color: Color.fromARGB(167, 255, 255, 255),
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
    );
  }
}
//frontend noti done