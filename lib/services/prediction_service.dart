import 'package:dio/dio.dart';

class PredictionService {
  static Future<String> predict(
    double n,
    double p,
    double k,
    double temp,
    double humidity,
    double ph,
    double rainfall,
  ) async {
    try {
      rainfall = 176.0;
      final res = await Dio().get(
          "http://192.168.45.205:5000/?n=$n&p=$p&k=$k&temp=$temp&humidity=$humidity&ph=$ph&rainfall=$rainfall");
      var str = res.toString();
      var start = "['";
      var end = "']";

      final startIndex = str.indexOf(start);
      final endIndex = str.indexOf(end, startIndex + start.length);

      final substr = str.substring(startIndex + start.length, endIndex);
      return substr;
    } catch (e) {
      return e.toString();
    }
  }
}
