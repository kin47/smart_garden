part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = _Init;

  const factory HomeEvent.getNews() = _GetNews;
}
