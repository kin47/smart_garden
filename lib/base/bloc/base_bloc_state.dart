import 'package:equatable/equatable.dart';

import 'bloc_status.dart';

abstract class BaseBlocState extends Equatable {
  const BaseBlocState({
    required this.status,
    this.message,
  });

  final BaseStateStatus status;
  final String? message; // Send error for UI

  @override
  List get props => [status, message];
}
