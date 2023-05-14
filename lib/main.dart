import 'package:flutter/material.dart';
import 'package:see_r/PlaybackPage.dart';
import 'package:see_r/home_page.dart';
import 'package:see_r/MorePage.dart';

import 'NotificationsPage.dart';

void main() => runApp(const MyApp());

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
        '/playback': (context) => const PlaybackPage(),
        '/more': (context) => const MorePage(),
      },
    );
  }
}
