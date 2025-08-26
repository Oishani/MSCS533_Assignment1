import 'package:flutter_test/flutter_test.dart';
import 'package:measures_converter/services/conversion_service.dart';
import 'package:measures_converter/models/unit.dart';

void main() {
  group('ConversionService', () {
    test('meters to feet', () {
      final meters = Unit(name: 'meters', type: 'distance', system: 'metric', toBaseFactor: 1.0);
      final feet = Unit(name: 'feet', type: 'distance', system: 'imperial', toBaseFactor: 0.3048);
      expect(ConversionService.convert(1, meters, feet), closeTo(3.28084, 0.0001));
    });
    test('kilograms to pounds', () {
      final kg = Unit(name: 'kilograms', type: 'weight', system: 'metric', toBaseFactor: 1.0);
      final lb = Unit(name: 'pounds', type: 'weight', system: 'imperial', toBaseFactor: 0.453592);
      expect(ConversionService.convert(1, kg, lb), closeTo(2.20462, 0.0001));
    });
    test('miles to kilometers', () {
      final miles = Unit(name: 'miles', type: 'distance', system: 'imperial', toBaseFactor: 1609.34);
      final km = Unit(name: 'kilometers', type: 'distance', system: 'metric', toBaseFactor: 1000.0);
      expect(ConversionService.convert(1, miles, km), closeTo(1.60934, 0.0001));
    });
    test('grams to ounces', () {
      final grams = Unit(name: 'grams', type: 'weight', system: 'metric', toBaseFactor: 0.001);
      final ounces = Unit(name: 'ounces', type: 'weight', system: 'imperial', toBaseFactor: 0.0283495);
      expect(ConversionService.convert(100, grams, ounces), closeTo(3.5274, 0.0001));
    });
  });
}
