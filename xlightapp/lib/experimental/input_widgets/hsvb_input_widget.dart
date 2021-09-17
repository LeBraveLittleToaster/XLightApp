import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
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

  Color curColor = Colors.blue;

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
        child: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 300, maxWidth: 800),
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
                        progressBarColor:Colors.transparent,
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
                initialValue: 0,
                innerWidget: (angle) => Container(),
                onChangeStart: (double startValue) {},
                onChangeEnd: (double endValue) {
                  print(endValue);
                },
              )),
        ),
      ),
    );
  }
}
