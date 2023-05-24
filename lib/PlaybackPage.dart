// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//import 'package:intl/intl.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PlaybackPage(
        channel: IOWebSocketChannel.connect('ws://34.171.93.214:65080'),
      ),
    );
  }
}

class PlaybackPage extends StatefulWidget {
  final WebSocketChannel channel;

  const PlaybackPage({Key? key, required this.channel}) : super(key: key);

  @override
  _PlaybackPageState createState() => _PlaybackPageState();
}

class _PlaybackPageState extends State<PlaybackPage> {
  final double videoWidth = 640;
  final double videoHeight = 480;

  double newVideoSizeWidth = 640;
  double newVideoSizeHeight = 480;

  late bool isLandscape;
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
    print('Screenshot button clicked!');
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

// ******************************************* Live Feed Window *******************************************

              OrientationBuilder(builder: (context, orientation) {
                var screenWidth = MediaQuery.of(context).size.width;
                var screenHeight = MediaQuery.of(context).size.height;

                if (orientation == Orientation.portrait) {
                  //screenWidth < screenHeight

                  isLandscape = false;
                  newVideoSizeWidth =
                      screenWidth > videoWidth ? videoWidth : screenWidth;
                  newVideoSizeHeight =
                      videoHeight * newVideoSizeWidth / videoWidth;
                } else {
                  isLandscape = true;
                  newVideoSizeHeight =
                      screenHeight > videoHeight ? videoHeight : screenHeight;
                  newVideoSizeWidth =
                      videoWidth * newVideoSizeHeight / videoHeight;
                }

                return Align(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: StreamBuilder(
                      stream: widget.channel.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        } else {
                          return GestureZoomBox(
                            maxScale: 5,
                            doubleTapScale: 2.0,
                            duration: const Duration(milliseconds: 200),
                            child: Image.memory(
                              snapshot.data,
                              gaplessPlayback: true,
                              width: newVideoSizeWidth,
                              height: newVideoSizeHeight,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 20)),
              // Button Row
// ******************************************* screenshot and record button *******************************************
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

// ******************************************* Content below the live feed window *******************************************
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
