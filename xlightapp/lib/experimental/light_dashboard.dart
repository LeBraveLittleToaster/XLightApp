import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_light_state.dart';
import 'package:xlightapp/experimental/light_state_setter.dart';
import 'package:xlightapp/stores/mts_light_store.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';

class LightDashboardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightDashboardState();
}

class _LightDashboardState extends State<LightDashboardWidget> {
  void _toggleLight(MtsLight light, LightStore lightStore) {
    lightStore.toggleLight(light);
  }

  @override
  Widget build(BuildContext context) {
    LightStore lightStore = Provider.of<LightStore>(context);
    ModeStore modeStore = Provider.of<ModeStore>(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(1.5),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1.3,
            children: lightStore.lights
                .map((light) =>
                    getGridLightItem(light, _toggleLight, lightStore, context))
                .toList(),
          ),
        ),
      ],
    );
  }
}

Widget getGridLightItem(
    MtsLight light,
    void Function(MtsLight light, LightStore lightStore) toggleLight,
    LightStore lightStore,
    BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LightStateSetterWidget(light: light))),
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 8, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    light.isOn ? "On" : "Off",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  FlutterSwitch(
                      width: 50.0,
                      height: 32.0,
                      value: light.isOn,
                      onToggle: (state) => toggleLight(light, lightStore)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                child: Text(light.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Text(light.location, style: const TextStyle(fontSize: 10)),
            ],
          ),
        )),
  );
}


/*
SwitchListTile(value: value, onChanged: onChanged
          trailing: IconButton(
            iconSize: 36,
            icon: Icon(
              light.isOn ? Icons.lightbulb : Icons.lightbulb_outline,
              color: light.isOn ? Colors.yellow : Colors.grey,
            ),
            onPressed: () => toggleLight(light, lightStore),
          ),
          
          */