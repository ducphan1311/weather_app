import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_usecase.dart';

class WeatherService {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherService(this.getWeatherUseCase);

  Future<WeatherEntity> getWeather({double? latitude, double? longitude}) {
    return getWeatherUseCase.execute(
      latitude: latitude,
      longitude: longitude,
    );
  }
}