import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/weather_entity.dart';

part 'weather_dto.g.dart';

@JsonSerializable()
class WeatherDto extends WeatherEntity {
  @override
  double get currentTemp => currentTempRM ?? 0;

  @JsonKey(name: 'currentTemp')
  final double? currentTempRM;

  @override
  String get locationName => locationNameRM ?? '';

  @JsonKey(name: 'locationName')
  final String? locationNameRM;

  @override
  List<DailyForecastEntity> get dailyForecasts => dailyForecastsRM ?? [];

  @JsonKey(name: 'dailyForecasts')
  final List<DailyForecastDto>? dailyForecastsRM;

  WeatherDto({
    this.currentTempRM,
    this.locationNameRM,
    this.dailyForecastsRM,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final forecast = json['forecast'];

    if (current == null || forecast == null) {
      return _$WeatherDtoFromJson(json);
    }

    // Extract current temperature
    final currentTemp = current['main']['temp']?.toDouble();

    // Extract location name
    final locationName = current['name'] as String?;

    // Process forecast data to get daily averages
    final List<DailyForecastDto> forecasts = _processForecastData(forecast);

    return WeatherDto(
      currentTempRM: currentTemp,
      locationNameRM: locationName,
      dailyForecastsRM: forecasts,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherDtoToJson(this);

  // Helper method to process forecast data and calculate daily averages
  static List<DailyForecastDto> _processForecastData(
      Map<String, dynamic> forecastData) {
    final List<dynamic> list = forecastData['list'];

    // Group forecast data by day
    final Map<String, List<double>> dailyTemps = {};

    for (var item in list) {
      final timestamp = item['dt'] * 1000;
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final dateString = DateFormat('yyyy-MM-dd').format(date);

      if (!dailyTemps.containsKey(dateString)) {
        dailyTemps[dateString] = [];
      }

      dailyTemps[dateString]!.add(item['main']['temp']?.toDouble() ?? 0.0);
    }

    // Calculate average temperature for each day
    final List<DailyForecastDto> result = [];

    // Skip today (we already have current temperature)
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    dailyTemps.forEach((dateString, temps) {
      if (dateString != today && result.length < 4) {
        // Only include next 4 days
        final avgTemp = temps.reduce((a, b) => a + b) / temps.length;
        final date = DateFormat('yyyy-MM-dd').parse(dateString);

        result.add(DailyForecastDto(
          dateRM: date,
          avgTempRM: avgTemp,
        ));
      }
    });

    // Sort by date
    result.sort((a, b) => a.date.compareTo(b.date));

    return result;
  }
}

@JsonSerializable()
class DailyForecastDto extends DailyForecastEntity {
  @override
  DateTime get date => dateRM ?? DateTime.now();

  @JsonKey(name: 'date')
  final DateTime? dateRM;

  @override
  double get avgTemp => avgTempRM ?? 0;

  @JsonKey(name: 'avgTemp')
  final double? avgTempRM;

  DailyForecastDto({
    this.dateRM,
    this.avgTempRM,
  });

  factory DailyForecastDto.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DailyForecastDtoToJson(this);
}
