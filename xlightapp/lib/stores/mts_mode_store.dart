import 'package:flutter/foundation.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/net/requester.dart';

class ModeStore extends ChangeNotifier {
  bool isLoading = true;
  List<MtsMode> modes = [];

  ModeStore init() {
    Requester.getModeList().then((loadedModes) {
      isLoading = false;
      modes = loadedModes;
      notifyListeners();
    });
    return this;
  }

  setModes(List<MtsMode> modes) {
    print("Setting new modes:$modes");
    this.modes = modes;
    notifyListeners();
  }
}
