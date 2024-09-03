import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_garden/base/base_widget.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/features/presentation/weather/bloc/weather_bloc.dart';
import 'package:smart_garden/features/presentation/weather/widget/weather_item.dart';
import 'package:smart_garden/gen/assets.gen.dart';

@RoutePage()
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState
    extends BaseState<WeatherPage, WeatherEvent, WeatherState, WeatherBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const WeatherEvent.init());
  }

  @override
  void listener(BuildContext context, WeatherState state) {
    super.listener(context, state);
    switch (state.status) {
      case BaseStateStatus.showPopUp:
        DialogService.showInformationDialog(
          context,
          description: state.message,
          buttonText: 'setting'.tr(),
          onPressedButton: () async {
            await Geolocator.openAppSettings();
          },
        );
        break;
      case BaseStateStatus.failed:
        DialogService.showInformationDialog(
          context,
          description: state.message,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget renderUI(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              blocBuilder(
                (context, state) => Visibility(
                  visible: state.weather != null,
                  child: state.weather?.icon ?? const SizedBox.shrink(),
                ),
                buildWhen: (previous, current) =>
                    previous.weather != current.weather,
              ),
              SizedBox(height: 8.h),
              blocBuilder(
                (context, state) => Text(
                  state.city,
                  style: AppTextStyles.s20w700,
                ),
                buildWhen: (previous, current) => previous.city != current.city,
              ),
              SizedBox(height: 4.h),
              blocBuilder(
                (context, state) => Text(
                  '${state.temperature?.toStringAsFixed(1) ?? 0}°C',
                  style: AppTextStyles.s50w400,
                ),
                buildWhen: (previous, current) =>
                    previous.temperature != current.temperature,
              ),
              SizedBox(height: 8.h),
              blocBuilder(
                (context, state) => Text(
                  state.description,
                  style: AppTextStyles.s16w400,
                ),
                buildWhen: (previous, current) =>
                    previous.temperature != current.temperature,
              ),
              SizedBox(height: 8.h),
              blocBuilder(
                (context, state) => Text(
                  DateTimeUtils.getStringDate(
                      DateTimeUtils.getDateBasedOnTimezone(
                        DateTime.now(),
                        state.timezone ?? DateTimeConstants.defaultTimezone,
                      ),
                      Pattern.hhmmEEEEddMMyyyy,
                      languageCode: 'vi'),
                  style: AppTextStyles.s14w400,
                ),
                buildWhen: (previous, current) =>
                    previous.timezone != current.timezone,
              ),
              SizedBox(height: 24.h),
              _buildAdditionalWeatherItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalWeatherItems() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 20.h,
      children: [
        blocBuilder(
          (context, state) => WeatherItem(
            icon: Assets.svg.icLowTemperature.svg(
              width: 40.w,
            ),
            title: 'lowest_temperature'.tr(),
            value: '${state.minTemperature?.toStringAsFixed(1) ?? 0}°C',
          ),
          buildWhen: (previous, current) =>
              previous.minTemperature != current.minTemperature,
        ),
        blocBuilder(
          (context, state) => WeatherItem(
            icon: Assets.svg.icHighTemperature.svg(
              width: 40.w,
            ),
            title: 'highest_temperature'.tr(),
            value: '${state.maxTemperature?.toStringAsFixed(1) ?? 0}°C',
          ),
          buildWhen: (previous, current) =>
              previous.maxTemperature != current.maxTemperature,
        ),
        blocBuilder(
          (context, state) => WeatherItem(
            icon: Assets.images.icSunrise.image(
              width: 40.w,
            ),
            title: 'sunrise'.tr(),
            value: DateTimeUtils.getStringDate(
              state.sunrise,
              Pattern.hhmma,
            ),
          ),
          buildWhen: (previous, current) => previous.sunrise != current.sunrise,
        ),
        blocBuilder(
          (context, state) => WeatherItem(
            icon: Assets.images.icSunset.image(
              width: 40.w,
            ),
            title: 'sunset'.tr(),
            value: DateTimeUtils.getStringDate(
              state.sunset,
              Pattern.hhmma,
            ),
          ),
          buildWhen: (previous, current) => previous.sunset != current.sunset,
        ),
        blocBuilder(
          (context, state) => WeatherItem(
            icon: Assets.svg.icHumidity.svg(
              width: 40.w,
            ),
            title: 'humidity'.tr(),
            value: '${state.humidity ?? 0}%',
          ),
          buildWhen: (previous, current) =>
              previous.humidity != current.humidity,
        ),
      ],
    );
  }
}
