import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/enum/weather_enum.dart';
import 'package:smart_garden/features/domain/repository/weather_repository.dart';
import 'package:geocoding/geocoding.dart';

part 'weather_event.dart';

part 'weather_state.dart';

part 'weather_bloc.freezed.dart';

part 'weather_bloc.g.dart';

@injectable
class WeatherBloc extends BaseBloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._repository) : super(WeatherState.init()) {
    on<WeatherEvent>((event, emit) async {
      await event.when(
        init: () => onInit(emit),
        getWeather: (lat, lon) => onGetWeather(lat, lon, emit),
      );
    });
  }

  final WeatherRepository _repository;

  Future onInit(Emitter<WeatherState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'request_location_permission'.tr(),
        ),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(
          state.copyWith(
            status: BaseStateStatus.showPopUp,
            message: 'request_location_permission'.tr(),
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
          message: 'request_location_permission'.tr(),
        ),
      );
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );

    await onGetWeather(
      position.latitude,
      position.longitude,
      emit,
    );
  }

  Future onGetWeather(
    double lat,
    double lon,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final res = await _repository.fetchWeather(lat: lat, lon: lon);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lon);

    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
          weather: r.weather,
          description: r.description,
          city: '${placemarks[0].subAdministrativeArea ?? ''}, ${placemarks[0].administrativeArea ?? ''}',
          humidity: r.humidity,
          sunrise: r.sunrise,
          sunset: r.sunset,
          temperature: r.temperature,
          maxTemperature: r.maxTemperature,
          minTemperature: r.minTemperature,
          timezone: r.timezone,
        ),
      ),
    );
  }
}
