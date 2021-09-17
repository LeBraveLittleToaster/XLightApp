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
      Text("Mode=" + (widget.light.state?.modeId.toString() ?? "NotSet"))
    ];
    widgets.addAll(getInputWidgets(modeStore));
    return Scaffold(
      appBar: getXLightAppBar(widget.light.name),
      body: Column(
        children: widgets,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: Icon(
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

  List<Widget> getInputWidgets(ModeStore modeStore) {
    return getInputsForLight(widget.light.state?.modeId ?? 0, modeStore)
        .map((mtsInput) => buildWidgetForInput(mtsInput))
        .toList();
  }

  Widget buildWidgetForInput(MtsInput mtsInput) {
    switch (mtsInput.inputType) {
      case InputType.HSV:
        return HsvInputWidget(input: mtsInput);
      case InputType.HSVB:
        return HsvbInputWidget(input: mtsInput);
      case InputType.SINGLE_DOUBLE:
        return SingleInputWidget(input: mtsInput);
      case InputType.RANGE_2_DOUBLE:
        return Range2InputWidget(input: mtsInput);
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
