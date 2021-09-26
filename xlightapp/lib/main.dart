import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/components/mts/mts_control_group.dart';

import 'package:xlightapp/experimental/light_dashboard.dart';
import 'package:xlightapp/stores/mts_control_group_store.dart';
import 'package:xlightapp/stores/mts_light_store.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';

const bool isInTestState = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModeStore>(
            create: (_) => ModeStore().init(isInTestState)),
        ChangeNotifierProvider<MtsControlGroupStore>(
            create: (_) => MtsControlGroupStore().init(isInTestState)),
        ChangeNotifierProvider<LightStore>(
            create: (_) => LightStore().init(isInTestState))
      ],
      builder: (context, child) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            home: const MyHomePage(title: "Hi Title"));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _createLightName = TextEditingController();
  TextEditingController _createLightLocation = TextEditingController();

  void _onAddLightClicked(LightStore lightStore) async {
    const EdgeInsets insetsText = EdgeInsets.fromLTRB(16, 16, 16, 0);
    const EdgeInsets insetsTextField = EdgeInsets.fromLTRB(16, 0, 16, 16);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Add new light"),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.done))
              ]),
              Padding(
                padding: insetsText,
                child: Text("Name"),
              ),
              Padding(
                padding: insetsTextField,
                child: TextField(),
              ),
              Padding(
                padding: insetsText,
                child: Text("Location"),
              ),
              Padding(
                padding: insetsTextField,
                child: TextField(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LightStore lightStore = Provider.of<LightStore>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                child: Text("Drawer Head")),
            ListTile(
              title: const Text("Add Light"),
              onTap: () => _onAddLightClicked(lightStore),
            )
          ],
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color.fromARGB(255, 232, 237, 247)])),
          child: Center(child: LightDashboardWidget())),
    );
  }
}
