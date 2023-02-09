import 'package:hive/hive.dart';
part 'songs_model.g.dart';

@HiveType(typeId: 1)
class SongsDataModel {
  @HiveField(0)
  final String uri;
  @HiveField(1)
  final int duration;
  @HiveField(2)
  final String displayName;
  @HiveField(3)
  final String album;
  @HiveField(4)
  final String artist;
  @HiveField(5)
  final bool isFavourite;
  @HiveField(6)
  final int id;
  @HiveField(7)
  final int finderKey;
  @HiveField(8)
  final List<String> playlists;
  @HiveField(9)
  final int played;
  @HiveField(10)
  final List<String> recentlyPlayed;
  @HiveField(11)
  final String title;
  SongsDataModel(
      {required this.title,
      this.played = 0,
      required this.recentlyPlayed,
      required this.isFavourite,
      required this.playlists,
      required this.finderKey,
      required this.id,
      required this.uri,
      required this.duration,
      required this.displayName,
      required this.album,
      required this.artist});
}
