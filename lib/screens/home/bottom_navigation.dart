import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../constants/constants.dart';
import '../../functions/load_data.dart';
import '../../functions/song_playing.dart';
import '../now_playing.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: miniplayer,
        builder: (context, jaba, _) {
          return jaba == false
              ? const SizedBox()
              : ValueListenableBuilder(
                  valueListenable: PlayMusic.instance.nowPlayingData,
                  builder: (context, data, _) {
                    return ListTile(
                      onTap: () {
                        checkTheSong();
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
                          id: data.id,
                          type: ArtworkType.AUDIO),
                      title: Text(
                        data.displayName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle:
                          Text(data.artist, overflow: TextOverflow.ellipsis),
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
                                  valueListenable: playingIcon,
                                  builder: (context, playerIcon, _) {
                                    return IconButton(
                                      onPressed: () {
                                        if (PlayMusic.instance.audio.playing) {
                                          PlayMusic.instance.audio.pause();

                                          playerIcon = Icons.play_arrow_rounded;
                                        } else {
                                          PlayMusic.instance.audio.play();

                                          playerIcon = Icons.pause;
                                        }
                                      },
                                      icon: Icon(
                                        playerIcon,
                                        color: Colors.black54,
                                      ),
                                    );
                                  }),
                            ),
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

  checkTheSong() async {
    for (var i = 0; i < allSongs.value.length; i++) {
      if (allSongs.value[i].uri ==
          PlayMusic.instance.nowPlayingData.value.uri) {
        setState(() {
          indexOfPlaying = i;
          log('message');
        });
      }
    }
  }
}
