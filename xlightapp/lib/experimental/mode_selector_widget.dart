import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_light.dart';
import 'package:xlightapp/components/mts/mts_mode.dart';
import 'package:xlightapp/stores/mts_light_store.dart';

class ModeSelectorWidget extends StatefulWidget {
  final List<MtsMode> modes;
  final void Function(int) onModeSet;

  const ModeSelectorWidget(
      {Key? key, required this.modes, required this.onModeSet})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelectorWidget> {
  final _controller = PageController(viewportFraction: 1 / 5);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.modes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.onModeSet(widget.modes[index].modeId);
              Navigator.pop(context);
            },
            child: AbsorbPointer(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.ac_unit_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                      child: Text(widget.modes[index].name),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
