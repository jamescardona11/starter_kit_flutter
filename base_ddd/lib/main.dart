import 'package:flutter/material.dart';

import 'core/logger/logger.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  /// default constructor
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void a() {
    //   final a = Projectile()
    //       .method(Method.get)
    //       .target('target')
    //       .header('', 'value')
    //       .header('key', 'value');
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Text'),
      ),
      body: Container(
        child: Text('HomePage'),
      ),
    );
  }
}
