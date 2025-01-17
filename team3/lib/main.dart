import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/detect_fire.dart';

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
      title: 'Fire Detection',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(camera: camera),
    );
  }
}

class MainScreen extends StatelessWidget {
  final CameraDescription? camera;

  const MainScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fire Detection')),
      body: Center(
        child: ElevatedButton(
          child: const Text('서비스 시작'),
          onPressed: () {
            if (camera != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(camera: camera!),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('오류'),
                  content: const Text('카메라를 사용할 수 없습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}