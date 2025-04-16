import 'package:geolocator/geolocator.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_api_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<WeatherEntity> getCurrentWeather({
    double? latitude,
    double? longitude,
  }) async {
    // If coordinates are not provided, get current location
    if (latitude == null || longitude == null) {
      final position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    }

    return await dataSource.getWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}