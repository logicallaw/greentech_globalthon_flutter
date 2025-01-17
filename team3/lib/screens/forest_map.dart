import 'package:flutter/material.dart';
import 'package:team3/screens/device_camera.dart';

class ForestMap extends StatefulWidget {
  const ForestMap({super.key});

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          SizedBox.expand(
            child: Image.asset(
              'assets/images/forest.png',
              fit: BoxFit.cover,
            ),
          ),
          // 경고 버튼 1과 CCTV 버튼
          Positioned(
            top: 100, // Y 좌표
            left: 50, // X 좌표
            child: Column(
              children: [
                // 경고 버튼
                IconButton(
                  icon: const Icon(Icons.warning_amber_rounded),
                  color: Colors.green,
                  iconSize: 40,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('화재 경보: 위치 1')),
                    );
                  },
                ),
                // CCTV 버튼 (Flutter 기본 아이콘 사용)
                IconButton(
                  icon: const Icon(Icons.videocam_outlined), // 기본 아이콘 사용
                  color: Colors.white70, // 아이콘 색상
                  iconSize: 40, // 크기를 작게 설정
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('CCTV: 위치 1')),
                    );
                  },
                  splashColor: Colors.transparent, // 클릭 시 배경 투명
                  highlightColor: Colors.transparent, // 클릭 시 배경 투명
                ),
              ],
            ),
          ),
          // 경고 버튼 2와 CCTV 버튼
          Positioned(
            top: 200,
            right: 70,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.warning_amber_rounded),
                  color: Colors.red,
                  iconSize: 40,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('화재 경보: 위치 2')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.videocam_outlined), // 기본 아이콘 사용
                  color: Colors.white70, // 아이콘 색상
                  iconSize: 40, // 크기를 작게 설정
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DeviceCamera())
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
          ),
          // 경고 버튼 3와 CCTV 버튼
          Positioned(
            bottom: 150,
            left: 150,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.warning_amber_rounded),
                  color: Colors.green,
                  iconSize: 40,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('화재 경보: 위치 3')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.videocam_outlined), // 기본 아이콘 사용
                  color: Colors.white70, // 아이콘 색상
                  iconSize: 40, // 크기를 작게 설정
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('CCTV: 위치 3')),
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}