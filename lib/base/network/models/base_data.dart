import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_data.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  anyMap: true,
  explicitToJson: true,
)
class BaseListData<T> {
  BaseListData({this.data, this.status});

  factory BaseListData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseListDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseListDataToJson(this, toJsonT);

  @JsonKey(name: 'data')
  List<T>? data;
  @JsonKey(name: 'status')
  int? status;
}

@JsonSerializable(
  genericArgumentFactories: true,
  anyMap: true,
  explicitToJson: true,
)
class BaseData<T> {
  BaseData({
    this.data,
    this.status,
    this.message,
  });

  factory BaseData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseDataToJson(this, toJsonT);

  @JsonKey(name: 'data')
  T? data;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}
