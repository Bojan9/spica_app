import 'package:flutter/material.dart';
import 'logsPage.dart';

void main() {
  runApp(const Spica_App());
}

class Spica_App extends StatelessWidget {
  const Spica_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogsPage(),
    );
  }
}