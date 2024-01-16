
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/pages/splash.dart';
import 'package:moneymanager/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses',
      theme: myTheme,
      home: const Splash(),
    );
  }
}
