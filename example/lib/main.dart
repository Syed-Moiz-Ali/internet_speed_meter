import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _currentSpeed;
  final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();

  @override
  void initState() {
    super.initState();
    _currentSpeed = '';

    init();
  }

  void init() async {
    try {
      _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
        setState(() {
          _currentSpeed = event;
        });
        print('Event: $event');
      });
    } on PlatformException {
      _currentSpeed = 'Failed to get currentSpeed.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Example App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Speed: $_currentSpeed'),
          ],
        ),
      ),
    );
  }
}
