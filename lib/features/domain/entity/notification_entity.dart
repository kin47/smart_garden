import 'package:equatable/equatable.dart';
import 'package:smart_garden/features/data/model/notification_model/notification_model.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String message;
  final DateTime time;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.message,
    required this.time,
    required this.isRead,
  });

  factory NotificationEntity.fromModel(NotificationModel model) {
    return NotificationEntity(
      id: model.id ?? 0,
      message: model.message ?? '',
      time: model.time ?? DateTime.now(),
      isRead: model.isRead ?? false,
    );
  }

  NotificationEntity copyWith({
    int? id,
    String? message,
    DateTime? time,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    id,
    message,
    time,
    isRead,
  ];
}
