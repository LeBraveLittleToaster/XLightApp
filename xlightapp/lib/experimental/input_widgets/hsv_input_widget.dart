import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';

class HsvInputWidget extends StatefulWidget {
  final MtsInput input;

  const HsvInputWidget({Key? key, required this.input}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HsvInputWidget();
}

class _HsvInputWidget extends State<HsvInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Hsv");
  }
}
