import 'package:flutter/material.dart';
import 'package:musicplayer/functions/playlist_repo.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/screens/home/home_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void initState() {
    super.initState();

    PlaylistRepo.instance.getAllPlaylists();
    LoadData.instance.getAllSongs();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/image-removebg-preview.png',
              height: 120,
            ),
            const ListTile(
              title: Text(
                'Music',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
