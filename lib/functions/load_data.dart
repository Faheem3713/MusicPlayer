import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongsDataModel>> allSongs = ValueNotifier([]);
SongModel? jaba;

class LoadData {
  LoadData._privateConstructor();

  static final LoadData instance = LoadData._privateConstructor();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  getAllSongs() async {
    var per = await _audioQuery.permissionsRequest();
    if (per) {
      List<SongModel> all = await _audioQuery.querySongs();
      jaba = all[0];
      var box = await Hive.openBox<SongsDataModel>('songData');
      int flag;
      try {
        for (var element in all) {
          flag = 0;
          for (var val in box.values) {
            if (!val.uri.contains(element.uri!)) {
              continue;
            } else {
              flag = 1;
              break;
            }
          }
          if (flag == 0) {
            await box.add(SongsDataModel(
                title: element.title,
                recentlyPlayed: [],
                finderKey: 0,
                isFavourite: false,
                id: element.id,
                uri: element.uri ?? '',
                duration: element.duration ?? 0,
                displayName: element.displayName,
                album: element.album ?? "",
                artist: element.artist ?? "",
                playlists: []));
          }
          await getAllSongsFromDatabase();
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  getAllSongsFromDatabase() async {
    var box = await Hive.openBox<SongsDataModel>('songData');
    allSongs.value.clear();
    for (var e in box.keys) {
      final val = box.get(e);
      allSongs.value.add(SongsDataModel(
          title: val!.title,
          recentlyPlayed: val.recentlyPlayed,
          played: val.played,
          finderKey: e,
          isFavourite: val.isFavourite,
          id: val.id,
          uri: val.uri,
          duration: val.duration,
          displayName: val.displayName,
          album: val.album,
          artist: val.artist,
          playlists: val.playlists));
    }
    allSongs.notifyListeners();
  }

  addToFavourite(SongsDataModel val) async {
    var box = await Hive.openBox<SongsDataModel>('songData');

    await box.put(
        val.finderKey,
        SongsDataModel(
            title: val.title,
            recentlyPlayed: val.recentlyPlayed,
            played: val.played,
            playlists: val.playlists,
            finderKey: val.finderKey,
            isFavourite: true,
            id: val.id,
            uri: val.uri,
            duration: val.duration,
            displayName: val.displayName,
            album: val.album,
            artist: val.artist));
    await getAllSongsFromDatabase();
  }

  playingCount(SongsDataModel val) async {
    var box = await Hive.openBox<SongsDataModel>('songData');

    await box.put(
        val.finderKey,
        SongsDataModel(
            title: val.title,
            recentlyPlayed: val.recentlyPlayed,
            played: val.played + 1,
            playlists: val.playlists,
            finderKey: val.finderKey,
            isFavourite: val.isFavourite,
            id: val.id,
            uri: val.uri,
            duration: val.duration,
            displayName: val.displayName,
            album: val.album,
            artist: val.artist));

    await getAllSongsFromDatabase();
  }

  deleteFromFavourite(SongsDataModel val) async {
    var box = await Hive.openBox<SongsDataModel>('songData');
    await box.put(
        val.finderKey,
        SongsDataModel(
            title: val.title,
            recentlyPlayed: val.recentlyPlayed,
            played: val.played,
            playlists: val.playlists,
            finderKey: val.finderKey,
            isFavourite: false,
            id: val.id,
            uri: val.uri,
            duration: val.duration,
            displayName: val.displayName,
            album: val.album,
            artist: val.artist));
    await getAllSongsFromDatabase();
  }

  removeAndAddPlaylist(SongsDataModel val) async {
    var box = await Hive.openBox<SongsDataModel>('songData');
    await box.put(val.finderKey, val);
    getAllSongsFromDatabase();
  }

  clearDatabase() async {
    var box = await Hive.openBox<SongsDataModel>('songData');
    await box.clear();
    getAllSongsFromDatabase();
  }
}
