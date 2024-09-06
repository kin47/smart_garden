import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_email_request.freezed.dart';
part 'resend_email_request.g.dart';

@freezed
class ResendEmailRequest with _$ResendEmailRequest {
  const factory ResendEmailRequest({
    required String email,
  }) = _ResendEmailRequest;

  factory ResendEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendEmailRequestFromJson(json);
}