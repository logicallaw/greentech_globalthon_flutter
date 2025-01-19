import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeviceCamera extends StatefulWidget {
  const DeviceCamera({super.key});

  @override
  State<DeviceCamera> createState() => _DeviceCameraState();
}

class _DeviceCameraState extends State<DeviceCamera> {
  final List<String> cctvImages = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
  ];
  final String baseUrl = dotenv.get('GCP_SERVER');
  int currentIndex = 0; // 현재 이미지 인덱스
  late Timer _timer;

  String fireStatus = "Fetching..."; // 화재 상태 초기값
  double accuracy = 0.0; // 정확도 초기값

  @override
  void initState() {
    super.initState();

    // 1초마다 이미지 변경 및 서버 전송
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        currentIndex = (currentIndex + 7) % cctvImages.length; // 인덱스 순환
      });

      // 에셋에서 파일 읽기 및 서버 전송
      final imagePath = cctvImages[currentIndex];
      try {
        final base64Image = await loadAndEncodeImage(imagePath);
        await _sendImageToServer(base64Image); // 이미지 전송
      } catch (e) {
        print('Error loading or sending image: $e');
      }
    });
  }

  /// 에셋 파일을 로드하고 Base64로 인코딩한 문자열 반환
  Future<String> loadAndEncodeImage(String assetPath) async {
    try {
      // Flutter 에셋 파일 로드
      final byteData = await rootBundle.load(assetPath);
      final Uint8List bytes = byteData.buffer.asUint8List();

      // Base64로 인코딩
      final base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      throw Exception('Failed to load or encode image: $e');
    }
  }

  Future<void> _sendImageToServer(String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'base64Image': base64Image}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          fireStatus = responseData['message'] ?? 'No message';

          // probability 값을 안전하게 double로 변환
          final dynamic probabilityValue = responseData['probability'];
          if (probabilityValue is int) {
            accuracy = probabilityValue.toDouble() * 100; // int를 double로 변환
          } else if (probabilityValue is double) {
            accuracy = probabilityValue * 100; // 이미 double인 경우
          } else {
            accuracy = 0.0; // 다른 경우 기본값
          }
        });
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Failed to send image: $e');
    }
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
                gaplessPlayback: true,
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