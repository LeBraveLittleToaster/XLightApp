import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/stores/mts_light_store.dart';

class SingleInputWidget extends StatefulWidget {
  final MtsLight light;
  final int inputIndex;
  final MtsInput input;

  const SingleInputWidget(
      {Key? key,
      required this.input,
      required this.inputIndex,
      required this.light})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleInputWidget();
}

class _SingleInputWidget extends State<SingleInputWidget> {
  double _value = 0;
  @override
  void initState() {
    super.initState();
    _value = widget.light.state?.values[widget.inputIndex].values[0] ?? 0;
  }

  void setValue(double value, LightStore lightStore) {
    lightStore.updateLightStateValue(widget.light, widget.inputIndex, [value]);
  }

  @override
  Widget build(BuildContext context) {
    LightStore lightStore = Provider.of<LightStore>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 1,
      child: Column(
        children: [
          Text(widget.input.uiLabel),
          Slider(
            min: 0,
            max: 255,
            value: _value,
            onChanged: (v) => setState(() {
              _value = v;
            }),
            onChangeEnd: (v) => setValue(v, lightStore),
          ),
        ],
      ),
    );
  }
}
