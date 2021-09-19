import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_light_state.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/components/mts/mts_value.dart';
import 'package:xlightapp/net/requester.dart';

class LightStore extends ChangeNotifier {
  List<MtsLight> lights = [];

  LightStore init() {
    lights.add(MtsLight(
        name: "Headlamp",
        location: "Living Room",
        mac: "Mac1",
        isOn: false,
        supportedModes: [1, 2, 3, 5],
        state: null));
    lights.add(MtsLight(
        name: "TV Backlight",
        location: "Living Room",
        mac: "Mac2",
        isOn: false,
        supportedModes: [1, 4, 5],
        state: null));
    notifyListeners();
    /*
    Requester.getLightList().then((List<MtsLight> lights) {
      this.lights = lights;
      notifyListeners();
    });
    */
    return this;
  }

  void toggleLight(MtsLight light) {
    int indexOfLight = lights.indexOf(light);
    lights[indexOfLight].isOn = !lights[indexOfLight].isOn;
    notifyListeners();
  }

  void setMode(MtsLight light, MtsMode mode) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state =
        MtsLightState(modeId: mode.modeId, values: generateDefaultValues(mode));
    notifyListeners();
  }

  void updateLightStateValue(
      MtsLight light, int inputIndex, List<double> values) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state?.values[inputIndex].values = values;
    notifyListeners();
  }

  void setLightState(MtsLight light, MtsLightState state) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state = state;
    notifyListeners();
  }

  List<MtsValue> generateDefaultValues(MtsMode mode) {
    List<MtsValue> mtsValues = [];
    for (int i = 0; i < mode.inputs.length; i++) {
      List<double> values = [];
      mtsValues.add(MtsValue(
          valueId: i,
          values: getDefaultValuesForInputType(mode.inputs[i].inputType)));
    }
    return mtsValues;
  }

  List<double> getDefaultValuesForInputType(InputType inputType) {
    switch (inputType) {
      case InputType.HSV:
        return [0.0, 255.0, 255.0, 0.0];
      case InputType.HSVB:
        return [0.0, 255.0, 255.0, 0.0];
      case InputType.SINGLE_DOUBLE:
        return [255.0];
      case InputType.RANGE_2_DOUBLE:
        return [0.0, 255.0];
    }
  }
}
