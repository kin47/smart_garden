import 'package:freezed_annotation/freezed_annotation.dart';
part 'jwt_model.freezed.dart';
part 'jwt_model.g.dart';

int? _parseIntClaim(Object? value) {
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse(value?.toString() ?? '');
}

@freezed
abstract class JWTModel with _$JWTModel {
  const factory JWTModel({
    @JsonKey(name: 'sub', fromJson: _parseIntClaim) int? userId,
    @JsonKey(name: 'sid') String? sessionId,
    @JsonKey(name: 'jti') String? tokenId,
    @JsonKey(name: 'iat') int? issuedAt,
    @JsonKey(name: 'exp') int? expiresAt,
    @JsonKey(name: 'iss') String? issuer,
    @JsonKey(name: 'aud') String? audience,
    @JsonKey(name: 'token_type') String? tokenType,
    String? email,
    String? name,
    String? phoneNumber,
    bool? isAdmin,
    int? kitId,
    double? expiredAt,
  }) = _JWTModel;

  factory JWTModel.fromJson(Map<String, dynamic> json) => _$JWTModelFromJson(json);
}