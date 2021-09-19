import 'package:flutter/cupertino.dart';

class MtsValue extends ChangeNotifier {
  int valueId;
  List<double> values;
  MtsValue({required this.valueId, required this.values});

  factory MtsValue.fromJson(Map<String, dynamic> json) {
    List<double>? values = json["values"]?.cast<double>();
    return MtsValue(
        valueId: json["valueId"],
        values: values ??  []);
  }

  Map<String, dynamic> toJson() => {"valueId": valueId, "values": values};

  @override
  String toString() {
    return "{valueId=$valueId, values=$values}";
  }
}
