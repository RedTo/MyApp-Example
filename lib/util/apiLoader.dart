import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';

// Use this class to communicate with REST servers or HTTP servers
class APILoader {
  //method to get a json (or any other format) from a url
  static Future<String> getJson(String url) async {
    var internet = await isInternetConnected(); //check internet availability
    if (internet) {
      //if internet is connected
      var response = await get(url); // get the response
      //TODO error handling would be great here (check response.headers!)
      return response.body; // and just return the body
    }
    return null; //return null if no internet connection is available
  }

  //method to check if the phone is connected to the internet through mobile or wifi
  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }
}
