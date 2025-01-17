import 'dart:async';
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
    final url = Uri.parse('http://your-api-server.com/upload');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        print('Server Response: $responseData');
      } else {
        print('Error: ${response.statusCode}');
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