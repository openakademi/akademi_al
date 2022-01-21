// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_token_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JwtTokenEntity _$JwtTokenEntityFromJson(Map<String, dynamic> json) {
  return JwtTokenEntity(
    signedJWTToken: json['signedJWTToken'] as String,
  );
}

Map<String, dynamic> _$JwtTokenEntityToJson(JwtTokenEntity instance) =>
    <String, dynamic>{
      'signedJWTToken': instance.signedJWTToken,
    };
