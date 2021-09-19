import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_light_state.dart';
import 'package:xlightapp/components/mts/mts_value.dart';
import 'package:xlightapp/stores/mts_light_store.dart';

class HsvbInputWidget extends StatefulWidget {
  final MtsLight light;
  final int inputIndex;
  final MtsInput input;

  const HsvbInputWidget(
      {Key? key,
      required this.input,
      required this.inputIndex,
      required this.light})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HsvbInputWidget();
}

class _HsvbInputWidget extends State<HsvbInputWidget> {
  double _rangeValue = 0;
  double _dialValue = 0;

  @override
  void initState() {
    super.initState();
    _rangeValue =
        widget.light.state?.values[widget.inputIndex].values[3] ?? 255;
    _dialValue = widget.light.state?.values[widget.inputIndex].values[0] ?? 255;
  }

  void setColor(
      LightStore lightStore, double hue, double saturation, double value) {
    MtsLightState state = widget.light.state!;
    state.values[widget.inputIndex].values[0] = hue;
    state.values[widget.inputIndex].values[1] = saturation;
    state.values[widget.inputIndex].values[2] = value;
    lightStore.setLightState(widget.light, state);
  }

  void setBrightness(LightStore lightStore, double brightness) {
    MtsLightState state = widget.light.state!;
    state.values[widget.inputIndex].values[3] = brightness;
    lightStore.setLightState(widget.light, state);
  }

  @override
  Widget build(BuildContext context) {
    LightStore lightStore = Provider.of<LightStore>(context);
    List<double>? valuesNormalized = widget
        .light.state?.values[widget.inputIndex].values
        .map((e) => e / 255)
        .toList();
    if (valuesNormalized == null || valuesNormalized.length != 4) {
      return const Text("Failed to load state, something went wrong");
    }
    double width = MediaQuery.of(context).size.width.clamp(300, 500);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Center(
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 300, maxWidth: 800),
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          startAngle: 0,
                          angleRange: 360,
                          customWidths: CustomSliderWidths(
                              progressBarWidth: width / 8,
                              handlerSize: width / 16,
                              shadowWidth: 0,
                              trackWidth: width / 8),
                          customColors: CustomSliderColors(
                              progressBarColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              dynamicGradient: false,
                              hideShadow: true,
                              trackGradientStartAngle: 0,
                              trackGradientEndAngle: 360,
                              trackColors: [
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.cyan,
                                Colors.blue,
                                Colors.purple,
                                Colors.pink,
                                Colors.red
                              ]),
                          size: width * 0.8),
                      min: 0,
                      max: 255,
                      initialValue: _dialValue,
                      onChange: (x) => setState(() {
                        _dialValue = x;
                      }),
                      innerWidget: (angle) => Container(),
                      onChangeEnd: (double endValue) {
                        setColor(lightStore, endValue, 255, 255);
                      },
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                "Brightness",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Slider(
                min: 0,
                max: 255,
                onChangeEnd: (brightness) {
                  setBrightness(lightStore, brightness);
                },
                value: _rangeValue,
                onChanged: (double changedValues) {
                  setState(() {
                    _rangeValue = changedValues;
                  });
                })
          ],
        ),
      ),
    );
  }
}
