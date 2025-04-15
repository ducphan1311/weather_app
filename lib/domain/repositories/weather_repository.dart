import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather({
    double? latitude,
    double? longitude,
  });
}