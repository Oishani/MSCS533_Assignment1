import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../services/conversion_service.dart';

class MeasuresConverterScreen extends StatefulWidget {
  @override
  _MeasuresConverterScreenState createState() => _MeasuresConverterScreenState();
}

class _MeasuresConverterScreenState extends State<MeasuresConverterScreen> {
  final TextEditingController _valueController = TextEditingController();
  late Unit _fromUnit;
  late Unit _toUnit;
  String _result = '';
  String? _errorMessage;

  // Define metric and imperial units
  final List<Unit> _metricUnits = ConversionService.units.where((u) => u.system == 'metric').toList();
  final List<Unit> _imperialUnits = ConversionService.units.where((u) => u.system == 'imperial').toList();

  // Returns the opposite system units for the selected fromUnit, filtered by type
  List<Unit> get _toUnits => _metricUnits.contains(_fromUnit)
      ? _imperialUnits.where((u) => u.type == _fromUnit.type).toList()
      : _metricUnits.where((u) => u.type == _fromUnit.type).toList();

  @override
  void initState() {
    super.initState();
    // Default: metric to imperial
    _fromUnit = _metricUnits.first;
    _toUnit = _imperialUnits.first;
  }

  /// Handles conversion and input validation
  void _convert() {
    setState(() {
      _errorMessage = null;
      _result = '';
      double? value = double.tryParse(_valueController.text);
      if (value == null) {
        _errorMessage = 'Please enter a valid number.';
        return;
      }
      if (value < 0) {
        _errorMessage = 'Please enter a non-negative value.';
        return;
      }
      double convertedValue = ConversionService.convert(value, _fromUnit, _toUnit);
      _result = '${value.toStringAsFixed(3)} ${_fromUnit.name} are ${convertedValue.toStringAsFixed(3)} ${_toUnit.name}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Blue background for header
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Text('Value', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter value',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2), // Blue underline when focused
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              textAlign: TextAlign.left,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('From'),
            ),
            DropdownButton<Unit>(
              value: _fromUnit,
              items: [..._metricUnits, ..._imperialUnits].map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                  // Always reset toUnit to first of opposite system
                  _toUnit = _toUnits.first;
                });
              },
              isExpanded: true,
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('To'),
            ),
            DropdownButton<Unit>(
              value: _toUnit,
              items: _toUnits.map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
              isExpanded: true,
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _convert,
                child: Text('Convert'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: Text(_result, style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
