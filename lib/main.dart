import 'package:flutter/material.dart';
import 'screens/measures_converter_screen.dart';

void main() => runApp(MeasuresConverterApp());

class MeasuresConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MeasuresConverterScreen(),
    );
  }
}
