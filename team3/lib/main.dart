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
      title: 'Fire Detection System',
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
      appBar: AppBar(
        title: const Text(
          'Fire Detection System',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // 버튼 배경색 설정
            ),
            child: const Icon(
              Icons.camera_alt, // 카메라 아이콘 사용
              color: Colors.black, // 아이콘 색상 검정
            ),
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
          )
      ),
    );
  }
}