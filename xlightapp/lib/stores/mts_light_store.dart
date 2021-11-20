import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_light_state.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/components/mts/mts_value.dart';
import 'package:xlightapp/net/requester.dart';

class LightStore extends ChangeNotifier {
  List<MtsLight> lights = [];

  LightStore init(bool testMe) {
    if (testMe) {
      lights.add(MtsLight(
          lightId: "0",
          name: "Headlamp",
          location: "Living Room",
          mac: "Mac1",
          isOn: false,
          supportedModes: [1, 2, 3, 5],
          state: null));
      lights.add(MtsLight(
          lightId: "1",
          name: "TV Backlight",
          location: "Living Room",
          mac: "Mac2",
          isOn: false,
          supportedModes: [1, 4, 5],
          state: null));
      notifyListeners();
    } else {
      refreshLights();
    }
    return this;
  }

  Future<void> refreshLights() {
    var completer = Completer<void>();
    Requester.getLightList().then((List<MtsLight> lights) {
      this.lights = lights;
      print("++++++++++++++++++ LOADED LIGHTS +++++++++++++++++++");
      print(lights.toString());
      print("++++++++++++++++++ LOADED LIGHTS +++++++++++++++++++");
      completer.complete();
      notifyListeners();
    }).catchError((err, stack) {
      completer.completeError(err);
      return Future.error(err);
    });
    return completer.future;
  }

  void toggleLight(MtsLight light) {
    int indexOfLight = lights.indexOf(light);
    lights[indexOfLight].isOn = !lights[indexOfLight].isOn;
    synchronizeLightIsOn(light.lightId, lights[indexOfLight].isOn);
    notifyListeners();
  }

  void setMode(MtsLight light, MtsMode mode) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state =
        MtsLightState(modeId: mode.modeId, values: generateDefaultValues(mode));
    synchronizeLightStateToServer(light.lightId, lights[lightIndex].state!);
    notifyListeners();
  }

  void updateLightStateValue(
      MtsLight light, int inputIndex, List<double> values) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state?.values[inputIndex].values = values;
    synchronizeLightStateToServer(light.lightId, lights[lightIndex].state!);
    notifyListeners();
  }

  void setLightState(MtsLight light, MtsLightState state) {
    int lightIndex = lights.indexOf(light);
    lights[lightIndex].state = state;
    synchronizeLightStateToServer(light.lightId, lights[lightIndex].state!);
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

  void synchronizeLightStateToServer(String lightId, MtsLightState lightState) {
    print("Synchronizing lightstate: " + lightState.toString());
    Requester.setLightState(lightId, lightState)
        .then((value) => print("Success setting lightstate"));
  }

  void synchronizeLightIsOn(String lightId, bool isOn) {
    Requester.setLightIsOn(lightId, isOn)
        .then((value) => print("Success setting isOn"));
  }
}
