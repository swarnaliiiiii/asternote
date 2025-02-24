import 'package:flutter/material.dart';
import 'package:frontend/camera.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          Future.microtask(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraScreen()),
              ));
          return const Scaffold(); 
        },
      ),
    );
  }
}