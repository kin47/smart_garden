import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/features/domain/enum/ws_action_enum.dart';

part 'web_socket_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  anyMap: true,
  explicitToJson: true,
)
class WebSocketModel<T> {
  @JsonKey(name: "action")
  WSActionEnum? action;
  @JsonKey(name: "data")
  T? data;

  WebSocketModel({
    this.action,
    this.data,
  });

  factory WebSocketModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$WebSocketModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$WebSocketModelToJson(this, toJsonT);
}
