import 'package:flutter/cupertino.dart';
import 'package:xlightapp/components/mts/mts_value.dart';

class MtsLightState extends ChangeNotifier{
  int modeId;
  List<MtsValue> values;

  MtsLightState({required this.modeId, required this.values});

  factory MtsLightState.fromJson(Map<String, dynamic> json) {
    List? jsonValues = json["values"];
    
    return MtsLightState(
        modeId: json["modeId"],
        values:
            jsonValues == null || jsonValues.length == 0
                ? []
                : List.of(jsonValues.map((e) => MtsValue.fromJson(e))));
  }
  Map<String, dynamic> toJson() => {"modeId": modeId, "values": values};

  @override
  String toString() {
    return "{modeId=$modeId, values=$values}";
  }
}
