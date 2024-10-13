import 'package:freezed_annotation/freezed_annotation.dart';

enum SenderEnum {
  @JsonValue(0)
  user,
  @JsonValue(1)
  admin,
}