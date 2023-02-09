import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/model/playlist/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<PlayListDataModel>> playListSongs = ValueNotifier([]);

class PlaylistRepo {
  PlaylistRepo._privateConstructor();
  final OnAudioQuery audio = OnAudioQuery();
  static final PlaylistRepo instance = PlaylistRepo._privateConstructor();

  createPlaylist(PlayListDataModel song) async {
    var box = await Hive.openBox<PlayListDataModel>('playlistSongs');
    box.add(song);
    await getAllPlaylists();
  }

  updatePlaylist(PlayListDataModel val, String name, int index) async {
    var box = await Hive.openBox<PlayListDataModel>('playlistSongs');
    await box.putAt(index, PlayListDataModel(playlistName: name));
    await getAllPlaylists();
    String jaba = 'ssasofjsao';
    jaba.hashCode;
  }

  deletePlaylist(int id) async {
    var box = await Hive.openBox<PlayListDataModel>('playlistSongs');
    await box.deleteAt(id);
    await getAllPlaylists();
  }

  getAllPlaylists() async {
    var box = await Hive.openBox<PlayListDataModel>('playlistSongs');
    playListSongs.value.clear();
    playListSongs.value.addAll(box.values);

    playListSongs.notifyListeners();
  }

  clearDatabase() async {
    var box = await Hive.openBox<PlayListDataModel>('playlistSongs');
    var recentBox = await Hive.openBox<int>('recent');
    await box.clear();
    await recentBox.clear();
    await getAllPlaylists();
  }
}
