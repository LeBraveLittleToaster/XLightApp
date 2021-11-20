import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:xlightapp/components/mts/mts_input.dart';

class MtsMode extends ChangeNotifier {
  int modeId;
  String name;
  int changeDateUTC;
  List<MtsInput> inputs;
  MtsMode({
    required this.modeId,
    required this.changeDateUTC,
    required this.name,
    required this.inputs,
  });

  Map<String, dynamic> toMap() {
    return {
      'modeId': modeId,
      'changeDateUTC': changeDateUTC,
      'name': name,
      'inputs': inputs.map((x) => x.toMap()).toList(),
    };
  }

  factory MtsMode.fromMap(Map<String, dynamic> map) {
    return MtsMode(
      modeId: map['modeId'],
      name: map['name'],
      changeDateUTC: map['changeDateUTC'],
      inputs:
          List<MtsInput>.from(map['inputs']?.map((x) => MtsInput.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MtsMode.fromJson(String source) =>
      MtsMode.fromMap(json.decode(source));

  @override
  String toString() =>
      '{\n modeId: $modeId, \n changeDateUTC: $changeDateUTC, \n inputs: $inputs\n}';
}
