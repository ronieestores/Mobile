import 'package:flutter/material.dart';
import 'preloader.dart';  // Make sure to adjust this path based on your project structure

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      title: 'Election App',
      debugShowCheckedModeBanner: false,
      home: PreloaderIntro(),  // Use PreloaderIntro as the home widget
    );
  }
}
