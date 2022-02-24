import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_todo/generated/l10n.dart';
import 'package:not_todo/services/services.dart';
import 'package:not_todo/themes/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'cubits/cubits.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotTodoCubit(),
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Not Todo',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('pl'),
        ],
        theme: AppTheme().lightTheme(),
        darkTheme: AppTheme().darkTheme(),
        restorationScopeId: 'homeRestorationScope',
        initialRoute: '/homeScreen',
        routes: {
          '/homeScreen': (context) => const HomeScreen(),
          '/calendarScreen': (context) => const CalendarScreen(),
        },
      ),
    );
  }
}
