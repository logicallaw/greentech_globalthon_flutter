import 'dart:async';
import 'dart:convert'; // Base64 변환을 위해 추가
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Timer? _timer;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startCapturing() {
    setState(() {
      _isCapturing = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        await _initializeControllerFuture;
        final image = await _controller.takePicture();
        await _sendImageToServer(File(image.path));
      } catch (e) {
        print('Error capturing image: $e');
      }
    });
  }

  void _stopCapturing() {
    _timer?.cancel();
    setState(() {
      _isCapturing = false;
    });
  }

  Future<void> _sendImageToServer(File image) async {
    try {
      // 이미지를 Base64로 변환
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      // JSON 데이터 생성
      // HTTP POST 요청 보내기
      final response = await http.post(
        Uri.parse('https://www.logical-law.com/detect/send_image'),
        body: {
          'base64Image': base64Image,
        },
      );

      if (response.statusCode == 200) {
        print('Server Response: ${response.body}');
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Failed to send image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isCapturing ? Icons.stop : Icons.camera),
        onPressed: () {
          if (_isCapturing) {
            _stopCapturing();
          } else {
            _startCapturing();
          }
        },
      ),
    );
  }
}