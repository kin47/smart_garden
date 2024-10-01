import 'package:freezed_annotation/freezed_annotation.dart';

enum OwnerTypeEnum {
  @JsonValue(1)
  user,
  @JsonValue(2)
  admin,
}