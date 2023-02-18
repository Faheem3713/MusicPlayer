import 'package:flutter/material.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/functions/playlist_repo.dart';
import 'package:musicplayer/screens/settings/about.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/on_boarding.dart';
import 'package:musicplayer/screens/settings/privacy_policy.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<SettingsModel> _tileData = [];

  @override
  void initState() {
    super.initState();
    _getThings(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWigets(title: 'Settings'),
        body: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text(_tileData[index].name),
                  onTap: _tileData[index].onpressed,
                ),
            separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
            itemCount: _tileData.length));
  }

  _getThings(BuildContext context) {
    _tileData = [
      SettingsModel(
          name: 'About',
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const About(),
                ));
          }),
      SettingsModel(
          name: 'Privacy policy',
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ));
          }),
      SettingsModel(
          name: 'Reset App',
          onpressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  content: const Text(
                      'Are you sure you want to reset app..?It will delete all data'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          LoadData.instance.clearDatabase();
                          PlaylistRepo.instance.clearDatabase();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoarding(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'))
                  ],
                );
              },
            );
          }),
      SettingsModel(
          name: 'Share App',
          onpressed: () {
            Share.share(
                "https://play.google.com/store/apps/details?id=in.brototype.muzeeq");
          }),
    ];
  }
}

class SettingsModel {
  final String name;
  final void Function() onpressed;

  SettingsModel({required this.name, required this.onpressed});
}
