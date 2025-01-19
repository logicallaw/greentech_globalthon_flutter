import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'detect_fire.dart';
import 'forest_map.dart'; // CameraScreen이 정의된 파일을 import

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Welcome, Admin", // 상단에 추가된 텍스트
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 버튼 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // 둥근 모서리
                ),
                fixedSize: const Size(100, 100), // 버튼 크기 (너비, 높이)
              ),
              child: const Icon(
                Icons.map, // 지도 아이콘
                size: 50, // 아이콘 크기
                color: Colors.black, // 아이콘 색상
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForestMap()),
                );
              },
            ),
          ),
          const SizedBox(height: 16), // 하단 버튼과 여백 추가
        ],
      ),
    );
  }
}