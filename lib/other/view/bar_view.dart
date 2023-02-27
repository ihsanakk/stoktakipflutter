import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Text("//BAR", style: TextStyle(fontSize: 24)),
    );
  }
}
