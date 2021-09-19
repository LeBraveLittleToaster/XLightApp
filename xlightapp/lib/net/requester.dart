import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_light_state.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';

String http_key_content_type = "Content-Type";
String http_value_content_type = "application/json";
String api_url_web = "http://localhost:8080";
String api_url_android = "http://192.168.0.242:8080";

class Requester {
  static Future<List<MtsLight>> getLightList() {
    var completer = Completer<List<MtsLight>>();
    String url = (kIsWeb ? api_url_web : api_url_android) + "/api/lights";
    http.get(Uri.parse(url),
        headers: {http_key_content_type: http_value_content_type}).then((resp) {
      print(utf8.decode(resp.bodyBytes));
      List<dynamic> jsonData = jsonDecode(utf8.decode(resp.bodyBytes));
      List<MtsLight> lights =
          jsonData.map((e) => MtsLight.fromJson(e)).toList();
      completer.complete(lights);
    });
    return completer.future;
  }

  static Future<List<MtsMode>> getModeList() {
    var completer = Completer<List<MtsMode>>();
    String url = (kIsWeb ? api_url_web : api_url_android) + "/api/modes";
    http.get(Uri.parse(url),
        headers: {http_key_content_type: http_value_content_type}).then((resp) {
      print(utf8.decode(resp.bodyBytes));
      List<dynamic> jsonData = jsonDecode(utf8.decode(resp.bodyBytes));
      List<MtsMode> lights = jsonData.map((e) => MtsMode.fromMap(e)).toList();
      completer.complete(lights);
    });
    return completer.future;
  }

  static Future<void> setLightState(int lightId, MtsLightState state) {
    var completer = Completer<void>();
    String url = (kIsWeb ? api_url_web : api_url_android) +
        "/api/lights/"+lightId.toString()+"/state/" +
        state.modeId.toString() +
        "/set";
    http
        .put(Uri.parse(url),
            headers: {http_key_content_type: http_value_content_type},
            body: jsonEncode(state.values))
        .then((resp) {
      print("Finished setting values to server");
      completer.complete();
    });
    return completer.future;
  }

  static Future<void> setLightIsOn(int lightId, bool isOn) {
    var completer = Completer<void>();
    String url = (kIsWeb ? api_url_web : api_url_android) +
        "/api/lights/" +
        lightId.toString() +
        "/set?isOn=" +
        isOn.toString();
    http.put(Uri.parse(url),
        headers: {http_key_content_type: http_value_content_type}).then((resp) {
      print("Finished setting values to server");
      completer.complete();
    });
    return completer.future;
  }
}
