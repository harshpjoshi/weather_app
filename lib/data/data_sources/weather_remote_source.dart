import 'package:dio/dio.dart';
import 'package:weather_app/data/models/serializers.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  Future<List<WeatherModel>> fetchWeather(double lat, double lon) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': '37ea9939152496e5de6ca532f93817fd',
      },
    );

    final data = response.data['list'];
    List weatherList = data
        .map((json) =>
            serializers.deserializeWith(WeatherModel.serializer, json))
        .toList();

    return weatherList.map((model) => model as WeatherModel).toList();
  }
}
