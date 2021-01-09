import 'package:flutter/material.dart';

import 'utils/theme.dart';
import 'views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Info Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      home: HomePage(),
    );
  }
}
