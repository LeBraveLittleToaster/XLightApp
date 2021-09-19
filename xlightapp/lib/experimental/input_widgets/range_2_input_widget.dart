import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/experimental/input_widgets/input_consts.dart';
import 'package:xlightapp/stores/mts_light_store.dart';

class Range2InputWidget extends StatefulWidget {
  final MtsLight light;
  final int inputIndex;
  final MtsInput input;

  const Range2InputWidget(
      {Key? key,
      required this.input,
      required this.inputIndex,
      required this.light})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _Range2InputWidget();
}

class _Range2InputWidget extends State<Range2InputWidget> {
  RangeValues _rangeValues = RangeValues(0, 0);
  @override
  void initState() {
    super.initState();
    var startV = widget.light.state?.values[widget.inputIndex].values[0] ?? 0;
    var endV = widget.light.state?.values[widget.inputIndex].values[1] ?? 255;
    _rangeValues = RangeValues(startV, endV);
  }

  void setRangeValue(RangeValues rangeValues, LightStore lightStore) {
    lightStore.updateLightStateValue(
        widget.light, widget.inputIndex, [rangeValues.start, rangeValues.end]);
  }

  @override
  Widget build(BuildContext context) {
    LightStore lightStore = Provider.of<LightStore>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 1,
      child: Column(
        children: [
          Padding(
            padding: inputTextInsets,
            child: Text(
              widget.input.uiLabel,
              style: inputTextStyle,
            ),
          ),
          RangeSlider(
            min: 0,
            max: 255,
            values: _rangeValues,
            onChanged: (v) => setState(() {
              _rangeValues = v;
            }),
            onChangeEnd: (v) {
              setRangeValue(v, lightStore);
            },
          ),
        ],
      ),
    );
  }
}
