import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/services/weather_service.dart';
import '../../../domain/entities/weather_entity.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService _weatherService;

  WeatherCubit(this._weatherService) : super(WeatherInitial());

  Future<void> getWeather() async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherService.getWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> refreshWeather() async {
    try {
      final currentState = state;
      if (currentState is WeatherLoaded) {
        emit(WeatherLoading());
      }
      final weather = await _weatherService.getWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}