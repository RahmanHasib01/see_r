import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

  bool isLandscape = false;

  late String _timestring = '';

  final GlobalKey _globalKey = GlobalKey();

  final _imageSaver = ImageGallerySaver();

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

  @override
  void initState() {
    super.initState();
    // ...
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;
      });
    });
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
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
                    height: newVideoSizeHeight,
                    width: newVideoSizeWidth,
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: isLandscape ? 0 : 0),
                              Stack(children: [
                                RepaintBoundary(
                                  key: _globalKey,
                                  child: GestureZoomBox(
                                    maxScale: 5,
                                    doubleTapScale: 2.0,
                                    duration: const Duration(milliseconds: 200),
                                    child: Image.memory(
                                      snapshot.data,
                                      gaplessPlayback: true,
                                      width: newVideoSizeWidth,
                                      height: newVideoSizeHeight,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                        'ESP32\'s cam',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        'Live | $_timestring',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ))
                              ]),
                              /* Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        IconButton(
                                          icon: const Icon(
                                            Icons.videocam,
                                            size: 24,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                            icon: const Icon(
                                              Icons.photo_camera,
                                              size: 24,
                                            ),
                                            onPressed: onPictureButtonClicked),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.mic,
                                            size: 24,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.speaker,
                                            size: 24,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_alert,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            print('clicked0');
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ) */
                            ],
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 10)),
              // Button Row
// ******************************************* screenshot and record button *******************************************

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(150, 100, 79, 56),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.photo_camera,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: onPictureButtonClicked,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onPictureButtonClicked,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(150, 100, 79, 56),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.videocam,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

// ******************************************* Content below the live feed window *******************************************
            ],
          ),
        ),
      ),
      floatingActionButton: _getFab(),
    );
  }

  onPictureButtonClicked() async {
    await takeScreenShot();
  }

  takeScreenShot() async {
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      Fluttertoast.showToast(
        msg: "Failed to capture screenshot",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    ui.Image? image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      Fluttertoast.showToast(
        msg: "Failed to capture screenshot",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Uint8List pngBytes = byteData.buffer.asUint8List();
    final res =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

    if (res['isSuccess']) {
      Fluttertoast.showToast(
        msg: "Screenshot Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to save screenshot",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd hh:mm:ss aaa').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _timestring = _formatDateTime(now);
    });
  }

  Widget _getFab() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      visible: isLandscape,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.photo_camera),
          onTap: onPictureButtonClicked,
        ),
        SpeedDialChild(child: const Icon(Icons.videocam), onTap: () {})
      ],
    );
  }
}
