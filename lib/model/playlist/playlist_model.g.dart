// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListDataModelAdapter extends TypeAdapter<PlayListDataModel> {
  @override
  final int typeId = 0;

  @override
  PlayListDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListDataModel(
      playlistName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListDataModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.playlistName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
