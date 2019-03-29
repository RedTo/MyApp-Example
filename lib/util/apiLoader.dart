import 'dart:async';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';

class APILoader {
  static Future<String> getJson(String url) async {
    var internet = await isInternetConnected();
    if (internet) {
      var response = await get(url);
      return response.body;
    }
    return null;
  }

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }
}
