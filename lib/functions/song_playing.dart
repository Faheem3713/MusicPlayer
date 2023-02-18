import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicplayer/functions/load_data.dart';

import '../model/songs_model.dart';

class PlayMusic {
  ValueNotifier<SongsDataModel> nowPlayingData =
      ValueNotifier(allSongs.value[0]);
  PlayMusic._privateConstructor();
  static final PlayMusic instance = PlayMusic._privateConstructor();
  AudioPlayer audio = AudioPlayer();
  playTheSong(int value, List<SongsDataModel> widget) async {
    nowPlayingData.value = widget[value];
    final songList = ConcatenatingAudioSource(
        children: List.generate(
            widget.length,
            (index) => AudioSource.uri(
                Uri.parse(
                  widget[index].uri,
                ),
                tag: MediaItem(
                  id: widget[value].id.toString(),
                  artist: widget[value].artist,
                  title: widget[value].displayName,
                  artUri: Uri.parse('https://example.com/albumart.jpg'),
                ))));
    audio.setAudioSource(
      songList,
      initialIndex: value,
      initialPosition: Duration.zero,
    );

    // audio.setAudioSource(AudioSource.uri(Uri.parse(widget[value].uri),
    //     tag: MediaItem(
    //       id: widget[value].id.toString(),
    //       artist: widget[value].artist,
    //       title: widget[value].displayName,
    //       //  artUri: Uri.parse('https://example.com/albumart.jpg'),
    //     )));
    audio.play();
  }
}
