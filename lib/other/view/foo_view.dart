import 'package:flutter/material.dart';

class Foo extends StatelessWidget {
  const Foo({super.key});

  @override
  Widget build(BuildContext context) {
    print("FOO");
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Text("//FOO", style: TextStyle(fontSize: 24)),
    );
  }
}
