// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDto _$WeatherDtoFromJson(Map<String, dynamic> json) => WeatherDto(
      currentTempRM: (json['currentTemp'] as num?)?.toDouble(),
      locationNameRM: json['locationName'] as String?,
      dailyForecastsRM: (json['dailyForecasts'] as List<dynamic>?)
          ?.map((e) => DailyForecastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherDtoToJson(WeatherDto instance) =>
    <String, dynamic>{
      'currentTemp': instance.currentTempRM,
      'locationName': instance.locationNameRM,
      'dailyForecasts': instance.dailyForecastsRM,
    };

DailyForecastDto _$DailyForecastDtoFromJson(Map<String, dynamic> json) =>
    DailyForecastDto(
      dateRM:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      avgTempRM: (json['avgTemp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyForecastDtoToJson(DailyForecastDto instance) =>
    <String, dynamic>{
      'date': instance.dateRM?.toIso8601String(),
      'avgTemp': instance.avgTempRM,
    };
