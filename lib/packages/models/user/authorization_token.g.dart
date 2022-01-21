// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorizationTokenAdapter extends TypeAdapter<AuthorizationToken> {
  @override
  final int typeId = 7;

  @override
  AuthorizationToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthorizationToken()
      ..accessToken = fields[1] as String
      ..accessTokenExpiresAt = fields[2] as String
      ..refreshToken = fields[3] as String
      ..refreshTokenExpiresAt = fields[4] as String
      ..user = fields[9] as User
      ..userId = fields[5] as String
      ..roles = (fields[6] as List)?.cast<Roles>()
      ..organizations = (fields[7] as List)?.cast<Organization>()
      ..scopes = (fields[8] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, AuthorizationToken obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.accessTokenExpiresAt)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.refreshTokenExpiresAt)
      ..writeByte(9)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.organizations)
      ..writeByte(8)
      ..write(obj.scopes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorizationTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
