import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';

class HsvbInputWidget extends StatefulWidget {
  final MtsInput input;

  const HsvbInputWidget({Key? key,required this.input}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _HsvbInputWidget();
}

class _HsvbInputWidget extends State<HsvbInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Hsvb");
  }
}
