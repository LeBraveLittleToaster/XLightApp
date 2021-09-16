import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore: constant_identifier_names
enum InputType { HSV, HSVB, SINGLE_DOUBLE, RANGE_2_DOUBLE }

extension InputTypeDescriptor on InputType {
  String get value => describeEnum(this);
}

class MtsInput {
  InputType inputType;
  String jsonKey;
  String uiLabel;
  MtsInput({
    required this.inputType,
    required this.jsonKey,
    required this.uiLabel,
  });

  Map<String, dynamic> toMap() {
    return {
      'inputType': inputType.toString(),
      'jsonKey': jsonKey,
      'uiLabel': uiLabel,
    };
  }

  factory MtsInput.fromMap(Map<String, dynamic> map) {
    String jsonInputType = map["inputType"];
    InputType iType = InputType.values
        .firstWhere((e) => e.value.compareTo(jsonInputType) == 0);
    return MtsInput(
      inputType: iType,
      jsonKey: map['jsonKey'],
      uiLabel: map['uiLabel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MtsInput.fromJson(String source) =>
      MtsInput.fromMap(json.decode(source));

  @override
  String toString() =>
      'MtsInput(inputType: $inputType, jsonKey: $jsonKey, uiLabel: $uiLabel)';
}
