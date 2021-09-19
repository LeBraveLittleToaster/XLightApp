import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/experimental/input_widgets/hsv_input_widget.dart';
import 'package:xlightapp/experimental/input_widgets/hsvb_input_widget.dart';
import 'package:xlightapp/experimental/input_widgets/range_2_input_widget.dart';
import 'package:xlightapp/experimental/input_widgets/single_double_input_widget.dart';
import 'package:xlightapp/experimental/mode_selector_widget.dart';
import 'package:xlightapp/stores/mts_light_store.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';
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
    LightStore lightStore = Provider.of<LightStore>(context);
    ModeStore modeStore = Provider.of<ModeStore>(context);
    List<Widget> widgets = [
      Stack(alignment: Alignment.bottomRight, children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/sliver_bg.png',
            height: 50,
            fit: BoxFit.fitWidth,
          ),
        ),
        IconButton(
            onPressed: () => print("Hello World"),
            icon: Icon(
              Icons.photo,
              color: Colors.white,
            )),
      ])
    ];
    widgets.addAll(getInputWidgets(modeStore, widget.light));
    widgets.add(Container(
      height: 100,
    ));
    return Scaffold(
      appBar: getXLightAppBar(widget.light.name),
      body: ListView(
        children: widgets,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.black,
        ),
        elevation: 0,
        onPressed: () => showModalBottomSheet(
          isDismissible: true,
          enableDrag: false,
          context: context,
          builder: (context) => ModeSelectorWidget(
              modes: modeStore.modes
                  .where((element) =>
                      widget.light.supportedModes.contains(element.modeId))
                  .toList(),
              onModeSet: (modeId) =>
                  onModeSelected(modeId, modeStore, lightStore)),
        ),
      ),
    );
  }

  void onModeSelected(int modeId, ModeStore modeStore, LightStore lightStore) {
    lightStore.setMode(widget.light,
        modeStore.modes.firstWhere((element) => element.modeId == modeId));
  }

  List<Widget> getInputWidgets(ModeStore modeStore, MtsLight light) {
    return getInputsForLight(widget.light.state?.modeId ?? 0, modeStore)
        .asMap()
        .entries
        .map((mtsInputEntry) =>
            buildWidgetForInput(light, mtsInputEntry.key, mtsInputEntry.value))
        .toList();
  }

  Widget buildWidgetForInput(
      MtsLight light, int inputIndex, MtsInput mtsInput) {
    switch (mtsInput.inputType) {
      case InputType.HSV:
        return HsvInputWidget(
            light: light, inputIndex: inputIndex, input: mtsInput);
      case InputType.HSVB:
        return HsvbInputWidget(
            light: light, inputIndex: inputIndex, input: mtsInput);
      case InputType.SINGLE_DOUBLE:
        return SingleInputWidget(
            light: light, inputIndex: inputIndex, input: mtsInput);
      case InputType.RANGE_2_DOUBLE:
        return Range2InputWidget(
            light: light, inputIndex: inputIndex, input: mtsInput);
    }
  }

  List<MtsInput> getInputsForLight(int modeId, ModeStore modeStore) {
    try {
      return modeStore.modes
          .firstWhere((element) => element.modeId == modeId)
          .inputs;
    } catch (error) {
      print(error);
      return [];
    }
  }
}
