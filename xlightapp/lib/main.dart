import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlightapp/experimental/mode_list_view.dart';
import 'package:xlightapp/net/requester.dart';
import 'package:xlightapp/stores/mts_light_store.dart';
import 'package:xlightapp/stores/mts_mode_store.dart';

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
            theme: ThemeData.dark(),
            home: MyHomePage(title: "Hi Title"));
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
  int _counter = 0;
  String text = "";

  void _incrementCounter() async {
    var lights = await Requester.getModeList();
    setState(() {
      text = lights.toString();
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: ModeListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
