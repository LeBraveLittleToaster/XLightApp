import 'package:flutter/foundation.dart';
import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/net/requester.dart';

class ModeStore extends ChangeNotifier {
  bool isLoading = true;
  List<MtsMode> modes = [];

  ModeStore init() {
    for (int i = 0; i <= 5; i++) {
      modes.add(MtsMode(
          modeId: i,
          changeDateUTC: 0,
          name: "Mode" + i.toString(),
          inputs: [
            MtsInput(
                inputType: InputType.HSVB,
                jsonKey: "i_" + i.toString() + "1",
                uiLabel: "ui_" + i.toString() + "_1"),
            MtsInput(
                inputType: InputType.RANGE_2_DOUBLE,
                jsonKey: "i_" + i.toString() + "1",
                uiLabel: "ui_" + i.toString() + "_1"),
            MtsInput(
                inputType: InputType.SINGLE_DOUBLE,
                jsonKey: "i_" + i.toString() + "1",
                uiLabel: "ui_" + i.toString() + "_1")
          ]));
    }
    notifyListeners();
    /*
    Requester.getModeList().then((loadedModes) {
      isLoading = false;
      modes = loadedModes;
      notifyListeners();
    });
    */
    return this;
  }

  setModes(List<MtsMode> modes) {
    print("Setting new modes:$modes");
    this.modes = modes;
    notifyListeners();
  }
}
