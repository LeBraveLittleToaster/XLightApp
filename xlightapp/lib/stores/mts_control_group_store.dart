import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:xlightapp/components/mts/mts_control_group.dart';
import 'package:xlightapp/net/requester.dart';

class MtsControlGroupStore extends ChangeNotifier {
  List<MtsControlGroup> controlGroups = [];

  MtsControlGroupStore init(bool testMe) {
    if (!testMe) {
      refreshLights();
    }

    return this;
  }

  Future<void> refreshLights() {
    var completer = Completer<void>();
    Requester.getControlGroupList().then((List<MtsControlGroup> groups) {
      controlGroups = groups;
      print("+++++++++++++++++ LOADED Control Groups START ++++++++++++++++++");
      print(groups.toString());
      print("++++++++++++++++++ LOADED Control Groups END +++++++++++++++++++");
      completer.complete();
      notifyListeners();
    }).catchError((err, stack) {
      completer.completeError(err);
      return Future.error(err);
    });
    return completer.future;
  }
}
