import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/experimental/light_dashboard.dart';
import 'package:xlightapp/stores/mts_light_store.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';
import 'package:xlightapp/xlight_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModeStore>(create: (_) => ModeStore().init()),
        ChangeNotifierProvider<LightStore>(create: (_) => LightStore().init())
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
  bool showsOnlyOffLights = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getXLightAppBar("Home"),
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
