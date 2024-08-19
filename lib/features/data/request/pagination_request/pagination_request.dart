import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/common/config/api_config.dart';
part 'pagination_request.freezed.dart';
part 'pagination_request.g.dart';

@freezed
class PaginationRequest with _$PaginationRequest {
  factory PaginationRequest({
    required int page,
    @Default(ApiConfig.limit) int limit,
  }) = _PaginationRequest;

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestFromJson(json);
}