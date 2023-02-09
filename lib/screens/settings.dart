import 'package:flutter/material.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/screens/about.dart';
import 'package:musicplayer/screens/home/home_page.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWigets(title: 'Settings'),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text(_tileData[index]),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About(),
                      )),
                ),
            separatorBuilder: (context, index) => kdivider,
            itemCount: _tileData.length));
  }

  final List _tileData = ['Terms and conditions', 'Privacy policy', 'About'];
}
