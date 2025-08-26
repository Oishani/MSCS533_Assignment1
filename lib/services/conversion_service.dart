import '../models/unit.dart';

/// Service for converting between units.
class ConversionService {
  static final List<Unit> units = [
    // Metric distance units
    Unit(name: 'meters', type: 'distance', system: 'metric', toBaseFactor: 1.0),
    Unit(name: 'kilometers', type: 'distance', system: 'metric', toBaseFactor: 1000.0),
    Unit(name: 'centimeters', type: 'distance', system: 'metric', toBaseFactor: 0.01),
    Unit(name: 'millimeters', type: 'distance', system: 'metric', toBaseFactor: 0.001),
    // Imperial distance units
    Unit(name: 'miles', type: 'distance', system: 'imperial', toBaseFactor: 1609.34),
    Unit(name: 'yards', type: 'distance', system: 'imperial', toBaseFactor: 0.9144),
    Unit(name: 'feet', type: 'distance', system: 'imperial', toBaseFactor: 0.3048),
    Unit(name: 'inches', type: 'distance', system: 'imperial', toBaseFactor: 0.0254),
    // Metric weight units
    Unit(name: 'kilograms', type: 'weight', system: 'metric', toBaseFactor: 1.0),
    Unit(name: 'grams', type: 'weight', system: 'metric', toBaseFactor: 0.001),
    Unit(name: 'milligrams', type: 'weight', system: 'metric', toBaseFactor: 0.000001),
    // Imperial weight units
    Unit(name: 'pounds', type: 'weight', system: 'imperial', toBaseFactor: 0.453592),
    Unit(name: 'ounces', type: 'weight', system: 'imperial', toBaseFactor: 0.0283495),
    Unit(name: 'stones', type: 'weight', system: 'imperial', toBaseFactor: 6.35029),
  ];

  /// Converts [value] from [from] unit to [to] unit.
  static double convert(double value, Unit from, Unit to) {
    if (from.type != to.type || from.system == to.system) return value;
    double baseValue = value * from.toBaseFactor;
    return baseValue / to.toBaseFactor;
  }
}
