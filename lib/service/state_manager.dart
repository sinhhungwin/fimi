import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fimi/models/weather_model.dart';
import 'package:fimi/service/api.dart';

final airData = FutureProvider<WeatherModel>((ref) async => fetchWeather());