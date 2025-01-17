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
          // 버튼 1
          Positioned(
            top: 100, // Y 좌표
            left: 50, // X 좌표
            child: IconButton(
              icon: const Icon(Icons.warning_amber_rounded),
              color: Colors.red,
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const DeviceCamera())
                );
              },
            ),
          ),
          // 버튼 2
          Positioned(
            top: 200, // Y 좌표
            right: 70, // X 좌표
            child: IconButton(
              icon: const Icon(Icons.warning_amber_rounded),
              color: Colors.orange,
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const DeviceCamera())
                );
              },
            ),
          ),
          // 버튼 3
          Positioned(
            bottom: 150, // Y 좌표
            left: 150, // X 좌표
            child: IconButton(
              icon: const Icon(Icons.warning_amber_rounded),
              color: Colors.yellow,
              iconSize: 40,
              onPressed: () {
                // // 버튼 3 클릭 시 동작
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('화재 경보: 위치 3')),
                // );
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const DeviceCamera())
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}