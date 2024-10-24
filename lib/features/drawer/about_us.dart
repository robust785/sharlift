import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = '/about-us';
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made by-",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Shrey",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Naman",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Pushkraj",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Mayur",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
