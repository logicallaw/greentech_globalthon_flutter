import 'dart:async';
import 'package:flutter/material.dart';

class DeviceCamera extends StatefulWidget {
  const DeviceCamera({super.key});

  @override
  State<DeviceCamera> createState() => _DeviceCameraState();
}

class _DeviceCameraState extends State<DeviceCamera> {
  final List<String> cctvImages = [
    'assets/images/1.png',
    'assets/images/2.png',
  ];
  int currentIndex = 0; // 현재 이미지 인덱스
  late Timer _timer;

  String fireStatus = "Fetching..."; // 화재 상태 초기값
  double accuracy = 0.0; // 정확도 초기값

  @override
  void initState() {
    super.initState();
    // 1초마다 이미지 변경
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % cctvImages.length; // 인덱스 순환
      });
    });

    // 서버 응답 시뮬레이션
    fetchDataFromServer();
  }

  // 서버로부터 데이터 가져오기 (시뮬레이션)
  Future<void> fetchDataFromServer() async {
    await Future.delayed(const Duration(seconds: 2)); // 2초 후 데이터 수신
    setState(() {
      fireStatus = "On Fire"; // 서버에서 받은 화재 상태
      accuracy = 95.34; // 서버에서 받은 정확도 (예제 값)
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머 해제
    super.dispose();
  }

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
          Container(
            width: MediaQuery.of(context).size.width, // 화면 너비에 맞춤
            color: Colors.white, // 배경색
            child: Center(
              child: Image.asset(
                cctvImages[currentIndex],
                height: 280, // 고정된 높이
                width: MediaQuery.of(context).size.width, // 화면 너비에 맞춤
                fit: BoxFit.cover, // 박스에 맞게 이미지 크기 조정
              ),
            ),
          ),
          // 서버 응답 데이터를 표시하는 텍스트
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fireStatus, // 화재 상태 텍스트
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  Text(
                    "Accuracy: ${accuracy.toStringAsFixed(2)}%", // 정확도 텍스트
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}