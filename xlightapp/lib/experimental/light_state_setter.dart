import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/xlight_appbar.dart';

class LightStateSetterWidget extends StatefulWidget {
  final MtsLight light;

  const LightStateSetterWidget({Key? key, required this.light})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightStateSetterState();
}

class _LightStateSetterState extends State<LightStateSetterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getXLightAppBar(widget.light.name),
    );
  }
}
