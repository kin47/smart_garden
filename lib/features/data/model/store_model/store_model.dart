import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_model.freezed.dart';

part 'store_model.g.dart';

@freezed
class StoreModel with _$StoreModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StoreModel({
    int? id,
    String? name,
    String? phoneNumber,
    String? address,
    double? latitude,
    double? longitude,
  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
}
