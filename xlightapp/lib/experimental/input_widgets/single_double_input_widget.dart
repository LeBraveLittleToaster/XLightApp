import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';

class SingleInputWidget extends StatefulWidget {
  final MtsInput input;

  const SingleInputWidget({Key? key,required this.input}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SingleInputWidget();
}

class _SingleInputWidget extends State<SingleInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Single");
  }
}
