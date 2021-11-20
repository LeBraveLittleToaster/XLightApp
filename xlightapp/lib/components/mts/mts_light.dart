import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'mts_light_state.dart';

class MtsLight with ChangeNotifier {
  Image? picture;
  String lightId;
  String name;
  String location;
  String mac;
  bool isOn;
  List<int> supportedModes;
  MtsLightState? state;

  MtsLight({
    this.picture,
    required this.lightId,
    required this.name,
    required this.location,
    required this.mac,
    required this.isOn,
    required this.supportedModes,
    required this.state,
  });

  factory MtsLight.fromJson(Map<String, dynamic> json) => MtsLight(
      picture: _convertToImage(json["picture"]),
      lightId: json["lightId"] ?? "",
      name: json["name"] ?? "Name not found",
      location: json["location"] ?? "No location set",
      mac: json["mac"] ?? "No mac found",
      isOn: json["isOn"] ?? false,
      state:
          json["state"] == null ? null : MtsLightState.fromJson(json["state"]),
      supportedModes: json["supportedModes"] == null
          ? []
          : json["supportedModes"].cast<int>());

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "mac": mac,
        "state": state?.toJson(),
        "supportedModes": supportedModes
      };

  static Image? _convertToImage(String? picture) {
    if (picture == null) {
      return null;
    }
    return Image.memory(
      Base64Decoder()
          .convert(Utf8Decoder().convert(Base64Decoder().convert(picture))),
      height: 50,
      fit: BoxFit.fitWidth,
    );
  }

  @override
  String toString() {
    return "{\n lightId=$lightId,\n name=$name,\n location=$location,\n supportedModes=$supportedModes,\n mac=$mac,\n isOn=$isOn,\n state=$state\n}";
  }
}
