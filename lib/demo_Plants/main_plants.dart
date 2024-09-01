import 'package:appthoitiet/demo_Plants/view_plant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlantsApp());
}

class PlantsApp extends StatefulWidget {
  const PlantsApp({super.key});

  @override
  State<StatefulWidget> createState() => _PlantsApp();
}

class _PlantsApp extends State<PlantsApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: ViewPlant(
        onThemeChanged: _changeTheme,
      ),
    );
  }

  void _changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
}
