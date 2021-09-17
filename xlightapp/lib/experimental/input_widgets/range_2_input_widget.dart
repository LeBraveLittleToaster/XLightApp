import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';

class Range2InputWidget extends StatefulWidget {
  final MtsInput input;

  const Range2InputWidget({Key? key,required this.input}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Range2InputWidget();
}

class _Range2InputWidget extends State<Range2InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Range2");
  }
}
