part of '../weather_page.dart';

class _CurrentTemperatureLocationWidget extends StatelessWidget {
  const _CurrentTemperatureLocationWidget({required this.weather});
  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme =
        theme.extension<AppThemeExtension>() ?? AppThemeExtension.light;

    return Container(
      width: double.infinity,
      color: Colors.black12.withValues(alpha: 0.05),
      child: Column(
        children: [
          const SizedBox(height: 56),
          Text(
            '${weather.currentTemp.round()}°',
            style: theme.textTheme.displayLarge?.copyWith(
              color: appTheme.temperatureColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            weather.locationName,
            style: theme.textTheme.displayMedium?.copyWith(
              color: appTheme.locationColor,
            ),
          ),
          const SizedBox(height: 62),
        ],
      ),
    );
  }
}
