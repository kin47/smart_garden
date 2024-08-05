import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum RoleType {
  admin('admin'),
  user('user');

  const RoleType(this.value);

  final String value;
}
