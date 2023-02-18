import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:http/http.dart' as http;
import '../functions/load_data.dart';
import '../functions/song_playing.dart';

int indexOfPlaying = 0;

class NowPlaying extends StatefulWidget {
  NowPlaying(
      {super.key,
      required this.songData,
      required this.intex,
      required this.toStart});
  List<SongsDataModel> songData;
  final int intex;
  final bool toStart;
  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  // final _player = AudioPlayer();
  String lyricsText = '';
  ValueNotifier<Duration> position = ValueNotifier(Duration.zero);
  bool isFavourite = false;
  ValueNotifier<Color> shuffleColor = ValueNotifier(Colors.white60);
  ValueNotifier<bool> isRepeat = ValueNotifier(false);
  List<SongsDataModel> ogData = [];
  Icon playerIcon = const Icon(
    Icons.play_arrow_rounded,
    size: 30,
    color: kColor4,
  );
  @override
  void initState() {
    super.initState();
    ogData = List.from(widget.songData);
    PlayMusic.instance.playTheSong(widget.intex, widget.songData);
    // initFunction();
    // getLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF251B37),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.songData[indexOfPlaying].displayName,
                      style: const TextStyle(color: kColor4, fontSize: 16),
                    ),
                    kHeight,
                    Text(widget.songData[indexOfPlaying].artist,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13)),
                  ],
                ),
                QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(10),
                    artworkHeight: MediaQuery.of(context).size.width * .75,
                    artworkWidth: MediaQuery.of(context).size.width * .9,
                    nullArtworkWidget: Image.asset(
                      'assets/images/moooz.png',
                      height: 200,
                    ),
                    id: widget.songData[indexOfPlaying].id,
                    type: ArtworkType.AUDIO),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: lyricsText.isEmpty
                                            ? const Text(
                                                'No lyrics found for this song',
                                                textAlign: TextAlign.center,
                                                style: klyricsTextStyle)
                                            : Text(
                                                lyricsText.split(
                                                    '...'.splitMapJoin(''))[0],
                                                textAlign: TextAlign.center,
                                                style: klyricsTextStyle,
                                              ),
                                      ));
                            },
                            icon: const Icon(
                              Icons.lyrics,
                              color: kColor4,
                            )),
                        IconButton(
                            onPressed: () {
                              !isFavourite
                                  ? LoadData.instance.addToFavourite(
                                      widget.songData[indexOfPlaying])
                                  : LoadData.instance.deleteFromFavourite(
                                      widget.songData[indexOfPlaying]);
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: isFavourite ? Colors.red : kColor4,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ValueListenableBuilder(
                          valueListenable: position,
                          builder: (context, data, _) {
                            return Row(
                              children: [
                                Text(formatTime(position.value),
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 13)),
                                Expanded(
                                  child: Slider(
                                    min: 0,
                                    inactiveColor: const Color(0xFFFFECEF),
                                    activeColor: const Color(0xFFFFCACA),
                                    value: position.value.inSeconds
                                                .toDouble() <=
                                            double.parse(Duration(
                                                    milliseconds: widget
                                                        .songData[
                                                            indexOfPlaying]
                                                        .duration)
                                                .inSeconds
                                                .toString())
                                        ? position.value.inSeconds.toDouble()
                                        : 0,
                                    max: double.parse(Duration(
                                            milliseconds: widget
                                                .songData[indexOfPlaying]
                                                .duration)
                                        .inSeconds
                                        .toString()),
                                    onChanged: (value) async {
                                      position.value =
                                          Duration(seconds: value.toInt());

                                      try {
                                        await PlayMusic.instance.audio.seek(
                                          Duration(
                                              seconds:
                                                  position.value.inSeconds),
                                        );
                                      } catch (e) {
                                        rethrow;
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                    formatTime(Duration(
                                        milliseconds: widget
                                            .songData[indexOfPlaying]
                                            .duration)),
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 13))
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (shuffleColor.value == Colors.white) {
                                shuffleColor.value = Colors.white38;

                                widget.songData.clear();
                                widget.songData.addAll(ogData);
                              } else {
                                shuffleColor.value = Colors.white;
                                widget.songData.shuffle();
                              }
                            },
                            icon: ValueListenableBuilder(
                                valueListenable: shuffleColor,
                                builder: (context, forcolor, _) {
                                  return Icon(Icons.shuffle_rounded,
                                      color: shuffleColor.value);
                                })),
                        CircleAvatar(
                            backgroundColor: const Color(0xFF372948),
                            child: IconButton(
                                onPressed: () {
                                  if (indexOfPlaying > 0 &&
                                      isRepeat.value == false) {
                                    indexOfPlaying--;
                                    setState(() {
                                      PlayMusic.instance.playTheSong(
                                          indexOfPlaying, widget.songData);
                                    });
                                  } else {
                                    setState(() {
                                      PlayMusic.instance.playTheSong(
                                          indexOfPlaying, widget.songData);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous_rounded,
                                  color: kColor4,
                                ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: const Color(0xFF372948),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (PlayMusic.instance.audio.playing) {
                                      PlayMusic.instance.audio.pause();
                                    } else {
                                      PlayMusic.instance.audio.play();
                                    }
                                  });
                                },
                                icon: playerIcon),
                          ),
                        ),
                        CircleAvatar(
                            backgroundColor: const Color(0xFF372948),
                            child: IconButton(
                                onPressed: () {
                                  if (indexOfPlaying <
                                          widget.songData.length - 1 &&
                                      isRepeat.value == false) {
                                    indexOfPlaying++;
                                    setState(() {
                                      PlayMusic.instance.playTheSong(
                                          indexOfPlaying, widget.songData);
                                    });
                                  } else {
                                    setState(() {
                                      PlayMusic.instance.playTheSong(
                                          indexOfPlaying, widget.songData);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  color: kColor4,
                                ))),
                        IconButton(
                            onPressed: () async {
                              isRepeat.value = !isRepeat.value;
                            },
                            icon: ValueListenableBuilder(
                                valueListenable: isRepeat,
                                builder: (context, forRepeat, _) {
                                  return Icon(
                                    Icons.repeat,
                                    color: isRepeat.value == false
                                        ? Colors.white38
                                        : Colors.white,
                                  );
                                })),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  getLyrics() async {
    final text = widget.songData[widget.intex].title.split(' -');
    String url =
        "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=${text[0]}&q_artist=${widget.songData[widget.intex].artist}&apikey=a1513fa57e2fe52afa260b30984a8e4f";
    Response response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      lyricsText = data['message']['body']['lyrics']['lyrics_body'];
    }
  }

  initFunction() async {
    indexOfPlaying = widget.intex;

    widget.songData[indexOfPlaying].isFavourite == true
        ? isFavourite = true
        : isFavourite = false;
    indexOfPlaying = widget.intex;
    PlayMusic.instance.audio.positionStream.listen((event) {
      position.value = event;
      if (event.inMilliseconds == widget.songData[indexOfPlaying].duration) {
        if (indexOfPlaying < widget.songData.length - 1) {
          indexOfPlaying++;
          PlayMusic.instance.playTheSong(indexOfPlaying, widget.songData);
        } else {
          PlayMusic.instance.playTheSong(indexOfPlaying, widget.songData);
        }
      }
    });

    PlayMusic.instance.audio.playingStream.listen((event) {
      setState(() {
        if (event) {
          playerIcon = const Icon(Icons.pause, size: 30, color: kColor4);
        } else {
          playerIcon = const Icon(
            Icons.play_arrow_rounded,
            size: 30,
            color: kColor4,
          );
        }
      });
    });

    if (widget.toStart) {
      await LoadData.instance.playingCount(widget.songData[widget.intex]);
      PlayMusic.instance.playTheSong(indexOfPlaying, widget.songData);

      var box = await Hive.openBox<int>('recent');
      final val = box.values.toList();
      val.removeWhere((element) => element == widget.songData[widget.intex].id);
      await box.clear();
      val.insert(0, widget.songData[indexOfPlaying].id);
      box.addAll(val);
      playerIcon = const Icon(
        Icons.pause,
        size: 30,
      );
    }
    miniplayer.value = true;
  }

  String formatTime(Duration duration) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
