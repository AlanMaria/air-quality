import 'package:agri_hack/services/blynk_services.dart';
import 'package:dio/dio.dart';

import '../API_KEY.dart';
import '../models/weather/weather.dart';

class WeatherServices {
  static const WEATHER_API_URL =
      "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/";

  static Future<Weather> getWeather(String location) async {
    StatusCode code;
    String url = "$WEATHER_API_URL$location/?key=$WEATHER_API_TOKEN";

    Weather weather = Weather(
        humidity: 0.0,
        temp: 0.0,
        precip: 0.0,
        precipprob: 0.0,
        datetimeEpoch: 0);
    try {
      final res = await Dio().get(url);
      weather = Weather.fromJson(res.data["currentConditions"]);
      print(weather);

      code = StatusCode.SUCCESS;
    } catch (e) {
      code = StatusCode.FAILURE;
    }
    return weather;
  }
}
