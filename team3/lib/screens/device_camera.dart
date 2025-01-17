import 'package:flutter/material.dart';

class DeviceCamera extends StatefulWidget {
  const DeviceCamera({super.key});

  @override
  State<DeviceCamera> createState() => _DeviceCameraState();
}

class _DeviceCameraState extends State<DeviceCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hello')
    );
  }
}