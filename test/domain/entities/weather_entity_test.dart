import 'package:flutter_test/flutter_test.dart';
import 'package:test_261224/domain/entities/weather_entity.dart';

class MockWeatherEntity extends WeatherEntity {
  @override
  double get currentTemp => 25.5;

  @override
  List<DailyForecastEntity> get dailyForecasts => [
        MockDailyForecastEntity(),
        MockDailyForecastEntity(),
      ];

  @override
  String get locationName => 'Test City';
}

class MockDailyForecastEntity extends DailyForecastEntity {
  @override
  double get avgTemp => 22.0;

  @override
  DateTime get date => DateTime(2023, 1, 1);
}

void main() {
  group('WeatherEntity', () {
    test('props should contain all properties', () {
      final entity = MockWeatherEntity();
      expect(entity.props, [entity.currentTemp, entity.locationName, entity.dailyForecasts]);
    });

    test('equality works correctly', () {
      final entity1 = MockWeatherEntity();
      final entity2 = MockWeatherEntity();
      expect(entity1, equals(entity2));
    });
  });

  group('DailyForecastEntity', () {
    test('props should contain all properties', () {
      final entity = MockDailyForecastEntity();
      expect(entity.props, [entity.date, entity.avgTemp]);
    });

    test('equality works correctly', () {
      final entity1 = MockDailyForecastEntity();
      final entity2 = MockDailyForecastEntity();
      expect(entity1, equals(entity2));
    });
  });
}