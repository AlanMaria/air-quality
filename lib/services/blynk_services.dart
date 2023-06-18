import 'package:agri_hack/API_KEY.dart';
import 'package:agri_hack/models/measures.dart';
import 'package:dio/dio.dart';

class BlynkServices {
  static const API_URL =
      "https://api.thingspeak.com/channels/2048261/feeds.json?results=2";

  static Future<ServerReturns> getValues() async {
    Measures _measures = Measures();
    StatusCode status = StatusCode.EXECUTION;

    // the last element shows if the call was successful
    // use try catch and if some exception occurs, return a 0 arr
    // And show a snackbar using the status
    try {
      // pull stuff using dio

      final response = await Dio().get(API_URL);
      final data = response.data["feeds"];
      _measures.temperature = double.parse(data[0]["field1"]);
      _measures.CO = double.parse(data[0]["field2"]);
      _measures.smoke = double.parse(data[0]["field3"]);

      status = StatusCode.SUCCESS;
      print("SUCCESS");
    } catch (e) {
      status = StatusCode.FAILURE;
      print("FAILED: $e");
    }
    return ServerReturns(status: status, measures: _measures);
  }
}

enum StatusCode {
  SUCCESS,
  FAILURE,
  EXECUTION,
}

class ServerReturns {
  StatusCode status;
  Measures measures;

  ServerReturns({required this.status, required this.measures});
}
