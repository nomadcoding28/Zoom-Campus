
import 'package:flutter/material.dart';
import 'package:zoomcampus/getstarted/get_started_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spotify",
      home: GetStartedPage(),
    );
  }
}
