import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamWeatherProvider = StreamProvider.autoDispose<String>((ref) async* {
  ref.keepAlive();
  while (true) {
    yield await WeatherRepo.fetchWeather();
    // await Future.delayed(const Duration(seconds: 5));
  }
});

class WeatherRepo {
  static final Random _random = Random();

  static Future<String> fetchWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    final weatherStates = ['Sunny', 'Cloudy', 'Rainy', 'Windy', 'Snowy'];
    final temperaature = 15 + _random.nextInt(20);
    final weatherState = weatherStates[_random.nextInt(weatherStates.length)];
    return '$weatherState, $temperaature°C';
  }
}
