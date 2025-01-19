import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/detect_fire.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Detection System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(camera: camera),
    );
  }
}