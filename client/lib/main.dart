import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tartanhacks2021/pages/router_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICode',
      theme: ThemeData.dark().copyWith(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: RouterPage(),
    );
  }
}
