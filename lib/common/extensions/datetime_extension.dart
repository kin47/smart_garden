import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String get formatTimeToMMddYYHHmm {
    final t = DateFormat("MM/dd/yyyy HH:mm").format(this);
    return t;
  }

  String get formatTimeToddMMYYHHmm {
    final t = DateFormat("dd/MM/yyyy HH:mm").format(this);
    return t;
  }

  String get formatTimeToddMMYYYY {
    final t = DateFormat("dd/MM/yyyy").format(this);
    return t;
  }

  String get formatTimeToHHmm {
    final t = DateFormat("HH:mm").format(this);
    return t;
  }

  String get formatTimeToEEEE {
    final t = DateFormat("EEEE").format(this);
    return t;
  }

  bool isSameDay(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  DateTime toMidnight() {
    return DateTime(year, month, day);
  }

  //get first day of month
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  //get last day of month
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime get getOnlyDate {
    return DateTime(year, month, day);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get formatTimeToHHmm {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  TimeOfDay add(Duration duration) {
    final int minutes = (minute + duration.inMinutes);
    final int hours = (hour + duration.inHours) % 24;
    if (minutes >= 60) {
      return TimeOfDay(hour: hours + minutes ~/ 60, minute: minutes % 60);
    }
    return TimeOfDay(hour: hours, minute: minutes);
  }

  TimeOfDay roundUp({int precision = 5}) {
    final int minutes = (minute / precision).ceil() * precision % 60;
    if (minutes == 60) {
      return TimeOfDay(hour: hour + 1, minute: 0);
    }
    return TimeOfDay(hour: hour, minute: minutes);
  }
}