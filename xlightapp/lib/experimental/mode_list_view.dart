import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:xlightapp/components/mts/mts_input.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/loading_view.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';

class ModeListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModeListViewState();
}

class ModeListViewState extends State<ModeListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModeStore>(
      builder: (context, store, child) {
        if (store.isLoading) {
          return LoadingView();
        }
        return ListView.builder(
            itemCount: store.modes.length,
            itemBuilder: (context, index) {
              MtsMode mode = store.modes[index];
              return ExpansionTile(
                childrenPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: mode.inputs
                    .map((e) => _ModeListViewSubItem(mtsInput: e))
                    .toList(),
                title: Text(mode.name),
                subtitle: Text(
                  "Mode id: " + mode.modeId.toString(),
                ),
              );
            });
      },
    );
  }
}

class _ModeListViewSubItem extends StatelessWidget {
  MtsInput mtsInput;
  _ModeListViewSubItem({
    Key? key,
    required this.mtsInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("InputType: " + mtsInput.inputType.toString().split(".").last);
  }
}
