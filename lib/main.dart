import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _randomString = "";
  String _randomStringFromFlutter = "";
  String _batteryLevel = "";
  static const platform = MethodChannel('example1');
  static const batteryLvlChannel = MethodChannel('example2');
  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platform.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      _counter = random;
    });
  }

  Future<void> _generateRandomString() async {
    String random = '';
    try {
      random = await platform.invokeMethod('getRandomString');
      print(random.runtimeType);
    } on PlatformException catch (e) {
      random = '';
    }
    setState(() {
      _randomString = random;
    });
  }

  Future<void> _generateRandomStringFromFlutter() async {
    String random = '';
    try {
      var arguments = {
        'len': 5,
        'prefix': 'flutter_',
      };
      random = await platform.invokeMethod('getRandomStringFromFlutter', arguments);
    } on PlatformException catch (e) {
      random = '';
    }
    setState(() {
      _randomStringFromFlutter = random;
    });
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await batteryLvlChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kotlin generates the following number:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Kotlin generates the following string:',
            ),
            Text(
              _randomString,
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Random String From Flutter:',
            ),
            Text(
              _randomStringFromFlutter,
              style: Theme.of(context).textTheme.headline4,
            ),const Text(
              'Battery Level:',
            ),
            Text(
              _batteryLevel,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _generateRandomNumber,
            tooltip: 'Generate Random Number',
            child: const Icon(Icons.arrow_upward),
          ),
          FloatingActionButton(
            onPressed: _generateRandomString,
            tooltip: 'Generate Random String',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: _generateRandomStringFromFlutter,
            tooltip: 'Generate Random String From Flutter',
            child: const Icon(Icons.arrow_downward),
          ),
          FloatingActionButton(
            onPressed: _getBatteryLevel,
            tooltip: 'Generate Battery Level',
            child: const Icon(Icons.battery_5_bar_outlined),
          ),
        ],
      ),
    );
  }
}