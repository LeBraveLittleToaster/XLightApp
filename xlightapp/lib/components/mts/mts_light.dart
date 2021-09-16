import 'package:flutter/cupertino.dart';

import 'mts_light_state.dart';

class MtsLight with ChangeNotifier {
  String name;
  String location;
  String mac;
  bool isOn;
  List<int> supportedModes;
  MtsLightState? state;

  MtsLight({
    required this.name,
    required this.location,
    required this.mac,
    required this.isOn,
    required this.supportedModes,
    required this.state,
  });

   factory MtsLight.fromJson(Map<String, dynamic> json) => MtsLight(
      name: json["name"] ?? "Name not found",
      location: json["location"] ?? "No location set",
      mac: json["mac"] ?? "No mac found",
      isOn : json["isOn"] ?? false,
      state: json["state"] == null ? null : MtsLightState.fromJson(json["state"]),
      supportedModes: json["supportedModes"] == null
          ? []
          : json["supportedModes"].cast<int>());

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "mac": mac,
        "state" : state?.toJson(),
        "supportedModes": supportedModes
      };

  @override
  String toString() {
    return "{name=$name, location=$location, mac=$mac, isOn=$isOn, state=$state}";
  }  

}
