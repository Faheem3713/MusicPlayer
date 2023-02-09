import 'package:hive/hive.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 0)
class PlayListDataModel {
  @HiveField(0)
  final String playlistName;

  PlayListDataModel({required this.playlistName});

  // final String? uri;
  // @HiveField(1)
  // final int? duration;
  // @HiveField(2)
  // final String? displayName;
  // @HiveField(3)
  // final String? album;
  // @HiveField(4)
  // final String? artist;
  // @HiveField(5)
  // final bool? isFavourite;
  // @HiveField(6)
  // final int? id;
  // @HiveField(7)
  // final int? finderKey;

}

class SongDatabaseModel {
  final String? uri;
  final int? duration;
  final String? displayName;
  final String? album;
  final String? artist;
  final bool? isFavourite;
  final int? id;
  final int? finderKey;
  final String? playlistName;
  SongDatabaseModel({
    this.isFavourite,
    this.finderKey,
    this.id,
    this.uri,
    this.duration,
    this.displayName,
    this.album,
    this.artist,
    this.playlistName,
  });
}
