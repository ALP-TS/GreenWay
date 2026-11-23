import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:greenway/splashscreen/splahscreen.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // Disable screenshots / screen recording
  await NoScreenshot.instance.screenshotOff();
  runApp(const MyApp());
}

void preventScreenshots() async {
  await NoScreenshot.instance.screenshotOff();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void secureScreen() async {
    await NoScreenshot.instance.screenshotOff();
    await WakelockPlus.enable();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenway',
      theme: Brand.theme(),
      // Cap very large system font sizes so fixed layouts never overflow.
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(
            textScaler: mq.textScaler.clamp(maxScaleFactor: 1.15),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: splashscreen(),
      debugShowCheckedModeBanner: false,
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
