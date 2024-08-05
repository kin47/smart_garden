import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum QuestionType {
  singleChoice('SINGLE_CHOICE'),
  multipleChoice('MULTIPLE_CHOICE');

  const QuestionType(this.value);

  final String value;
}
