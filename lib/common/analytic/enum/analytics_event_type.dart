import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum AnalyticsEventType {
  informationList(value: 'information_detail'),
  usefulInformation(value: 'useful_information');

  const AnalyticsEventType({
    required this.value,
  });
  final String value;
}
