import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_261224/domain/entities/weather_entity.dart';

import '../../../design_system_widgets/app_error_widget.dart';
import '../../../design_system_widgets/app_loading_widget.dart';
import '../../../themes/app_theme_extension.dart';
import '../../cubits/weather/weather_cubit.dart';

part 'widgets/current_temperature_location_widget.dart';
part 'widgets/four_day_forecast_widget.dart';

class WeatherPage extends StatefulWidget {
  static const path = '/weather_page';

  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    // Fetch weather data when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherCubit>().getWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>() ?? AppThemeExtension.light;
    
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WeatherCubit>().refreshWeather();
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: AppLoadingWidget());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<WeatherCubit>().refreshWeather();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CurrentTemperatureLocationWidget(weather: weather),
                    // 4-day forecast
                    _FourDayForecastWidget(weather: weather),
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            return Center(
              child: AppErrorWidget(
                message: state.message,
                onRetry: () async {
                  await context.read<WeatherCubit>().getWeather();
                },
              ),
            );
          }
          // Return an empty container for initial state
          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}