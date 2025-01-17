import 'package:flutter/material.dart';

class ForestMap extends StatefulWidget {
  const ForestMap({super.key});

  @override
  State<ForestMap> createState() => _ForestMapState();
}

class _ForestMapState extends State<ForestMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/forest.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}