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

      status = StatusCode.SUCCESS;
      print("SUCCESS");
    } catch (e) {
      status = StatusCode.FAILURE;
      print("FAILED: $e");
    }
    return ServerReturns(status: status, measures: _measures);
  }

  static Future<List> getSingleValue(int pin) async {
    print("Inside REST Service");
    StatusCode status = StatusCode.EXECUTION;
    double value = 0.0;
    try {
      final response = await Dio().get("$API_URL$API_TOKEN&v$pin");
      print("DATA : ${response.data}");
      value = response.data.toDouble();
      // TODO name this according to pin, or do a map in constants
      // TODO i have doubts with NPK, so I'm going to give garbage

      status = StatusCode.SUCCESS;
      print("SUCCESS");
    } catch (e) {
      status = StatusCode.FAILURE;
      print("FAILED: $e");
    }
    return [status, value];
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
