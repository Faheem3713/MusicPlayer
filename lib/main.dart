import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicplayer/model/playlist/playlist_model.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/on_boarding.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  if (!Hive.isAdapterRegistered(SongsDataModelAdapter().typeId)) {
    Hive.registerAdapter(SongsDataModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListDataModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListDataModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: appTheme,
        builder: (context, themaData, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: appTheme.value,
              home: OnBoarding());
        });
  }
}

ValueNotifier<ThemeData> appTheme = ValueNotifier(
    ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.grey[200])));
