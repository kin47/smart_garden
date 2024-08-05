// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

enum Pattern {
  hhmm,
  hhmmss,
  ddmmm,
  md,
  ddMMMMyyyyHHmm,
  ddMMyyyyHHmm,
  ddMMyyyyHHmmss,
  yyyyMMddHHmm,
  yyyyMMddHHmmWithSeparator,
  yyyyMMdd,
  yyyyMMdd_jp,
  yyyyMMddHHmmss,
  yyyyMMddHHmmss_jp,
  yyyyMMddWithSeparator,
  yyyyMMWithSeparator,
  yyyyMMddHHmmssWithSeparator,
  ddMMyyyyWithSeparator,
  ddMMMyyyyWithSeparator,
  yyyyMM,
  ddMMyyyy,
  hhmmEEEEddMMyyyy,
  hhmma,
  EEEE,
  MMMMyyyy,
  HHmmyyyyMMddWithSeparator,
  HHmmyyyyMMddWithLineSeparator,
  yyyyMMddE,
  MMddE,
}

extension PatternExtension on Pattern {
  String get pattern {
    switch (this) {
      case Pattern.hhmm:
        return 'HH:mm';
      case Pattern.hhmmss:
        return 'HH:mm:ss';
      case Pattern.ddmmm:
        return 'dd MMM';
      case Pattern.md:
        return 'M/d';
      case Pattern.ddMMyyyyHHmm:
        return 'dd/MM/yyyy HH:mm';
      case Pattern.ddMMMMyyyyHHmm:
        return 'dd/MMMM/yyyy HH:mm';
      case Pattern.ddMMyyyyHHmmss:
        return 'dd/MM/yyyy HH:mm:ss';
      case Pattern.yyyyMMddHHmm:
        return 'yyyy/MM/dd HH:mm';
      case Pattern.yyyyMMddHHmmWithSeparator:
        return 'yyyy-MM-dd HH:mm';
      case Pattern.HHmmyyyyMMddWithSeparator:
        return 'HH:mm dd/MM/yyyy';
      case Pattern.yyyyMMWithSeparator:
        return 'yyyy-MM';
      case Pattern.HHmmyyyyMMddWithLineSeparator:
        return 'HH:mm dd-MM-yyyy';
      case Pattern.yyyyMMddHHmmss:
        return 'yyyy-MM-dd HH:mm:ss';
      case Pattern.yyyyMMdd_jp:
        return 'yyyy/MM/dd (E)';
      case Pattern.yyyyMMddHHmmss_jp:
        return 'yyyy/MM/dd (E) HH:mm:ss';
      case Pattern.ddMMyyyy:
        return 'dd/MM/yyyy';
      case Pattern.yyyyMMdd:
        return 'yyyy/MM/dd';
      case Pattern.yyyyMMddWithSeparator:
        return 'yyyy-MM-dd';
      case Pattern.ddMMyyyyWithSeparator:
        return 'dd-MM-yyyy';
      case Pattern.ddMMMyyyyWithSeparator:
        return 'dd MMM yyyy';
      case Pattern.yyyyMMddHHmmssWithSeparator:
        return 'yyyy-MM-dd HH:mm:ss';
      case Pattern.hhmmEEEEddMMyyyy:
        return 'HH:mm, EEEE dd/MM/yyyy';
      case Pattern.hhmma:
        return 'hh:mm a';
      case Pattern.EEEE:
        return 'EEEE';
      case Pattern.MMMMyyyy:
        return 'MMMM yyyy';
      case Pattern.yyyyMMddE:
        return 'yyyy/MM/dd (E)';
      case Pattern.MMddE:
        return 'MM/dd (E)';
      case Pattern.yyyyMM:
        return 'yyyy/MM';
      default:
        return '';
    }
  }
}

const secondMillis = 1000;
const minuteMillis = 60 * secondMillis;
const hourMillis = 60 * minuteMillis;
const dayMillis = 24 * hourMillis;
const weekMillis = 7 * dayMillis;
const minuteSecond = 60;
const hourSecond = 60 * minuteSecond;
const monthMillis = 31 * dayMillis;
const quarterMillis = 3 * monthMillis;

class DateTimeUtils {
  static DateTime? getDateTime(dynamic dateToConvert, {Pattern? pattern}) {
    if (dateToConvert is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateToConvert);
    } else if (dateToConvert is String) {
      return DateFormat(pattern!.pattern).parse(dateToConvert);
    }
    return null;
  }

  static String getStringDate(
      dynamic dateToConvert,
      Pattern pattern, {
        String? languageCode,
      }) {
    if (dateToConvert == null) {
      return '';
    }

    final dateFormat = DateFormat(pattern.pattern, languageCode);
    if (dateToConvert is int) {
      final datetime = getDateTime(dateToConvert);
      return dateFormat.format(datetime!);
    } else if (dateToConvert is DateTime) {
      return dateFormat.format(dateToConvert.toLocal());
    }
    return '';
  }

  static int getTimestamp(dynamic dateToConvert, Pattern pattern) {
    if (dateToConvert is DateTime) {
      return dateToConvert.millisecondsSinceEpoch;
    } else if (dateToConvert is String) {
      final dateFormat = DateFormat(pattern.pattern);
      return dateFormat.parse(dateToConvert).millisecondsSinceEpoch;
    }
    return 0;
  }

  static DateTime? getDateFromDateAndTime({
    dynamic date,
    String? time,
    required Pattern pattern,
  }) {
    if (date == null || time == null) {
      return null;
    }
    if (date is String) {
      return getDateTime('$date $time', pattern: pattern);
    } else if (date is DateTime) {
      return getDateTime(
        '${getStringDate(date, Pattern.yyyyMMddWithSeparator)} $time',
        pattern: Pattern.yyyyMMddHHmmss,
      );
    }
    return null;
  }

  static String? getWeekdayForAnyDay(DateTime? date, String languageCode) {
    if (date == null) {
      return null;
    }
    return DateFormat('E', "JA").format(date).toUpperCase();
  }
}
