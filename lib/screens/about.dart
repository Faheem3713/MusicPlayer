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
            Image.asset(
              'assets/images/moooz.png',
              height: 170,
            ),
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: AssetImage('assets/images/mooz.png'),
            // ),
            const ListTile(
              title: Text(
                'Music',
                textAlign: TextAlign.center,
              ),
              subtitle: Text('Version 1.0.0', textAlign: TextAlign.center),
            ),
            const Text('Copyright 2023. All right reserved.')
          ],
        ),
      ),
    );
  }
}
