// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessTokenDataAdapter extends TypeAdapter<AccessTokenData> {
  @override
  final int typeId = 1;

  @override
  AccessTokenData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessTokenData(
      accessToken: fields[0] as String,
      expiresIn: fields[1] as int,
      userId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccessTokenData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.expiresIn)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
