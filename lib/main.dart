import 'package:flutter/material.dart';
import 'package:not_todo/themes/app_theme.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not Todo',
      theme: AppTheme().lightTheme(),
      darkTheme: AppTheme().darkTheme(),
      restorationScopeId: 'homeRestorationScope',
      initialRoute: '/homeScreen',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
