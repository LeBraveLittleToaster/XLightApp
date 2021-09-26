import 'package:flutter/foundation.dart';
import 'package:xlightapp/components/mts/mts_light.dart';

class MtsControlGroup extends ChangeNotifier{
  String name;
  List<MtsLight> lights;

  MtsControlGroup({required this.name, required this.lights});

  factory MtsControlGroup.fromJson(Map<String, dynamic> json) {
    List? jsonLights = json["lights"];
    
    return MtsControlGroup(
        name: json["name"],
        lights:
            jsonLights == null || jsonLights.length == 0
                ? []
                : List.of(jsonLights.map((e) => MtsLight.fromJson(e))));
  }
  Map<String, dynamic> toJson() => {"modeId": name, "values": lights};

  @override
  String toString() {
    return "{name=$name, lights=$lights}";
  }
}