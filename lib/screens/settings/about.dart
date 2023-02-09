import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/image-removebg-preview.png',
                  height: 120,
                ),
                const ListTile(
                  title: Text(
                    'Muzeeq',
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text('Version 1.0.0', textAlign: TextAlign.center),
                ),
              ],
            ),
            const Text('Copyright 2023. All right reserved.')
          ],
        ),
      ),
    );
  }
}
