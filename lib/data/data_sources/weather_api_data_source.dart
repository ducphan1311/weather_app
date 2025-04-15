import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dtos/weather_dto.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherApiDataSource {
  final Dio _dio;
  
  WeatherApiDataSource(this._dio);

  Future<WeatherEntity> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
      
      // Get current weather data
      final response = await _dio.get(
        'weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'units': 'metric', // For Celsius
          'appid': apiKey,
        },
      );
      
      // Get forecast data for next 4 days
      final forecastResponse = await _dio.get(
        'forecast',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'units': 'metric', // For Celsius
          'cnt': 40, // Get data for 5 days (8 points per day)
          'appid': apiKey,
        },
      );
      
      if (response.statusCode == 200 && forecastResponse.statusCode == 200) {
        final currentData = response.data;
        final forecastData = forecastResponse.data;
        
        // Combine the data for our model
        final combinedData = {
          'current': currentData,
          'forecast': forecastData,
        };
        
        // Create DTO which is already a WeatherEntity
        return WeatherDto.fromJson(combinedData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}