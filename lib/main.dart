import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    title: 'My App',
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    ),
  ));
}
