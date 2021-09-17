import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';

class SingleInputWidget extends StatefulWidget {
  final MtsLight light;
  final int inputIndex;
  final MtsInput input;

  const SingleInputWidget({Key? key,required this.input, required this.inputIndex, required this.light}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SingleInputWidget();
}

class _SingleInputWidget extends State<SingleInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Single");
  }
}
