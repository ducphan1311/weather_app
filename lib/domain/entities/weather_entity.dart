import 'package:equatable/equatable.dart';

abstract class WeatherEntity extends Equatable {
  double get currentTemp;
  String get locationName;
  List<DailyForecastEntity> get dailyForecasts;

  @override
  List<Object?> get props => [currentTemp, locationName, dailyForecasts];
}

abstract class DailyForecastEntity extends Equatable {
  DateTime get date;
  double get avgTemp;

  @override
  List<Object?> get props => [date, avgTemp];
}