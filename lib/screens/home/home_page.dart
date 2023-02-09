import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/constants/common/textHardcode.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/main.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

//ValueNotifier<AudioPlayer> audioNotifier = ValueNotifier(AudioPlayer());
ValueNotifier<bool> miniplayer = ValueNotifier(false);

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IconData switchMode = Icons.dark_mode_outlined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWigets(title: "Library", actions: [
          IconButton(
              onPressed: () {
                appTheme.value == ThemeData.dark()
                    ? appTheme.value = ThemeData.light().copyWith(
                        appBarTheme:
                            AppBarTheme(backgroundColor: Colors.grey[200]))
                    : appTheme.value = ThemeData.dark();
                switchMode == Icons.dark_mode_outlined
                    ? switchMode = Icons.light_mode_outlined
                    : switchMode = Icons.dark_mode_outlined;
                setState(() {});
              },
              icon: Icon(switchMode)),
          Text('   ')
        ]),
        body: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextHardCode.library[index].pages,
                      )),
                  leading: TextHardCode.library[index].icon,
                  title: Text(TextHardCode.library[index].text),
                  trailing: RichText(
                      text: const TextSpan(children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.chevron_right_rounded),
                    )
                  ])),
                ),
            separatorBuilder: (context, index) => index == 4
                ? const Divider(
                    thickness: 5,
                  )
                : kdivider,
            itemCount: TextHardCode.library.length),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}

PreferredSizeWidget AppBarWigets(
    {required String title, List<Widget> actions = const []}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        foregroundColor: kBlack,
        //    automaticallyImplyLeading: false,
        elevation: 0,
        //  backgroundColor: Color(0xFFEEEEEE),
        title: Text(
          title,
          style: const TextStyle(color: kBlack, fontSize: 13),
        ),
        actions: actions,
      ));
}

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: miniplayer,
        builder: (context, jaba, _) {
          return jaba == false
              ? SizedBox()
              : ValueListenableBuilder(
                  valueListenable: allSongs,
                  builder: (context, data, _) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlaying(
                                songData: allSongs.value,
                                intex: indexOfPlaying,
                                toStart: false,
                              ),
                            ));
                      },
                      leading: QueryArtworkWidget(
                          nullArtworkWidget:
                              Image.asset('assets/images/moooz.png'),
                          id: data[indexOfPlaying].id,
                          type: ArtworkType.AUDIO),
                      title: Text(
                        data[indexOfPlaying].displayName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(data[indexOfPlaying].album,
                          overflow: TextOverflow.ellipsis),
                      trailing: RichText(
                          text: TextSpan(
                              style: const TextStyle(color: kBlack),
                              children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: indexOfPlaying == 0
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        if (indexOfPlaying > 0) {
                                          indexOfPlaying--;
                                          PlayMusic.instance.playTheSong(
                                              indexOfPlaying, allSongs.value);
                                        }
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                          Icons.skip_previous_rounded),
                                      color: kBlack54,
                                      // iconSize: 40,
                                    ),
                            ),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: ValueListenableBuilder(
                                    valueListenable: playerIcon,
                                    builder: (context, iconData, _) {
                                      return IconButton(
                                        onPressed: () {
                                          if (PlayMusic
                                              .instance.audio.playing) {
                                            PlayMusic.instance.audio.pause();
                                            playerIcon.value = Icon(
                                                Icons.play_arrow_rounded,
                                                size: 30);
                                          } else {
                                            PlayMusic.instance.audio.play();
                                            playerIcon.value = Icon(
                                              Icons.pause,
                                              size: 30,
                                            );
                                          }
                                        },
                                        icon: iconData,
                                      );
                                    })),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: indexOfPlaying ==
                                        allSongs.value.length - 1
                                    ? const SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          if (indexOfPlaying <
                                              allSongs.value.length - 1) {
                                            indexOfPlaying++;
                                            PlayMusic.instance.playTheSong(
                                                indexOfPlaying, allSongs.value);
                                            setState(() {});
                                          }
                                        },
                                        icon:
                                            const Icon(Icons.skip_next_rounded),
                                        iconSize: 25,
                                        color: kBlack54,
                                      ))
                          ])),
                    );
                  });
        });
  }
}
