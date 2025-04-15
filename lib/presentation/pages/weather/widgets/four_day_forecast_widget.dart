part of '../weather_page.dart';

class _FourDayForecastWidget extends StatelessWidget {
  const _FourDayForecastWidget({required this.weather});
  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme =
        theme.extension<AppThemeExtension>() ?? AppThemeExtension.light;

    return Column(
      children: List.generate(
        weather.dailyForecasts.length,
        (index) {
          final forecast = weather.dailyForecasts[index];
          final day = DateFormat('EEEE').format(forecast.date);
          return Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appTheme.forecastTextColor,
                      ),
                    ),
                    Text(
                      '${forecast.avgTemp.round()} C',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appTheme.forecastTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 0.5),
            ],
          );
        },
      ),
    );
  }
}
