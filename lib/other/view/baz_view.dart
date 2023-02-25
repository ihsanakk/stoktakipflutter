import 'package:flutter/material.dart';

class Baz extends StatelessWidget {
  const Baz({super.key});

  @override
  Widget build(BuildContext context) {
    print("BAZ");
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Text("//BAZ", style: TextStyle(fontSize: 24)),
    );
  }
}
