import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';

class Range2InputWidget extends StatefulWidget {
  final MtsLight light;
  final int inputIndex;
  final MtsInput input;

  const Range2InputWidget({Key? key,required this.input, required this.inputIndex, required this.light}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Range2InputWidget();
}

class _Range2InputWidget extends State<Range2InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Range2");
  }
}
