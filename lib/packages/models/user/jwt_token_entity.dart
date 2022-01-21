import 'package:json_annotation/json_annotation.dart';

part 'jwt_token_entity.g.dart';

@JsonSerializable()
class JwtTokenEntity {
	final String signedJWTToken;

	JwtTokenEntity({this.signedJWTToken});

  factory JwtTokenEntity.fromJson(Map<String, dynamic> json) => _$JwtTokenEntityFromJson(json);

	Map<String, dynamic> toJson() => _$JwtTokenEntityToJson(this);

}
