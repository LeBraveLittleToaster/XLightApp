import 'package:flutter/material.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/net/requester.dart';

class LightStore extends ChangeNotifier {
  List<MtsLight> lights = [];

  LightStore init() {
    Requester.getLightList().then((List<MtsLight> lights) {
      this.lights = lights;
      notifyListeners();
    });
    return this;
  }

  void toggleLight(MtsLight light) {
    int indexOfLight = lights.indexOf(light);
    lights[indexOfLight].isOn = !lights[indexOfLight].isOn;
    notifyListeners();
  }
}
