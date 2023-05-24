import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:web_socket_channel/io.dart';

//pages
import 'package:see_r/PlaybackPage.dart';
import 'package:see_r/home_page.dart';
import 'package:see_r/MorePage.dart';
import 'NotificationsPage.dart';
import 'signin.dart';
//pages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'See_R',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/playback': (context) => PlaybackPage(
            channel: IOWebSocketChannel.connect('ws://34.171.93.214:65080')),
        '/more': (context) => const MorePage(),
        '/signin': (context) => const SigninPage(),
      },
    );
  }
}
