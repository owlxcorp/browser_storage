import 'package:flutter/material.dart';
import 'package:browser_storage/storage.dart';

void main() {
  SessionStorage()..addAll({'language': 'english', 'name': 'Session Man'});
  LocalStorage()..addAll({'language': 'english', 'name': 'Session Man'});
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = SessionStorage();
    final local = LocalStorage();

    return Column(
      children: [
        Text('Session User: ${session['name']}'),
        Text('Session Language: ${session['language']}'),
        Text('Local User: ${local['name']}'),
        Text('Local Language: ${local['language']}'),
      ],
    );
  }
}
