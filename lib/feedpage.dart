import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _currentIndex = 2;

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
          // Navigate to the Playback Page
          Navigator.pushNamed(context, '/notifications');
          break;
        case 2:
          // Navigate to the Live Feed Page
          Navigator.pushNamed(context, '/playback');
          break;
        case 3:
          // Navigate to the More Page
          Navigator.pushNamed(context, '/more');
          break;
        case 4:
          // Navigate to the Feedback Page
          Navigator.pushNamed(context, '/feedback');
          break;
      }
    }
  }

  void onPictureButtonClicked() {
    // Add your picture capture logic here
    print('Picture button clicked!');
  }

  void onVideoButtonClicked() {
    // Add your video recording logic here
    print('Video button clicked!');
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
            onTabChange: _onTabSelected,
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
              // Content above the live feed window
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding:
                        const EdgeInsets.only(left: 165, top: 10, bottom: 0),
                    child: const Text(
                      'LIVE FEED',
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
                      onTap: () {
                        // Add your search logic here
                        print('Search button clicked!');
                      },
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
              const Padding(padding: EdgeInsets.only(top: 30)),
              // Live Feed Window
              Align(
                child: Container(
                  width: 400,
                  height: 250,
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: const Text(
                    'Live Feed Window',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              // Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onPictureButtonClicked,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(150, 100, 79, 56),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onVideoButtonClicked,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(150, 100, 79, 56),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.videocam,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Content below the live feed window
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Additional Content',
                  style: TextStyle(
                    fontFamily: 'MyCustomFont',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 100, 79, 56),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
