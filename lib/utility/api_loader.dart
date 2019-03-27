import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

class API_Loader {
  static Future<Map<String, dynamic>> loadJson(
      BuildContext context, String url) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    var result = json.decode(await getJson(url));

    Navigator.pop(context);
    return result;
  }

  static Future<String> getJson(String url) async {
    var result = await isInternetConnected();
    if (result) {
      Response res = await get(url);
      return res.body;
    }
    return null;
  }

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }
}
