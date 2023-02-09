// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsDataModelAdapter extends TypeAdapter<SongsDataModel> {
  @override
  final int typeId = 1;

  @override
  SongsDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsDataModel(
      title: fields[11] as String,
      played: fields[9] as int,
      recentlyPlayed: (fields[10] as List).cast<String>(),
      isFavourite: fields[5] as bool,
      playlists: (fields[8] as List).cast<String>(),
      finderKey: fields[7] as int,
      id: fields[6] as int,
      uri: fields[0] as String,
      duration: fields[1] as int,
      displayName: fields[2] as String,
      album: fields[3] as String,
      artist: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongsDataModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uri)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.artist)
      ..writeByte(5)
      ..write(obj.isFavourite)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.finderKey)
      ..writeByte(8)
      ..write(obj.playlists)
      ..writeByte(9)
      ..write(obj.played)
      ..writeByte(10)
      ..write(obj.recentlyPlayed)
      ..writeByte(11)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
