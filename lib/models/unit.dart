/// Model representing a measurement unit.
class Unit {
  final String name;
  final String type; // 'distance' or 'weight'
  final String system; // 'metric' or 'imperial'
  final double toBaseFactor; // Factor to convert to base unit (meter or kilogram)

  const Unit({required this.name, required this.type, required this.system, required this.toBaseFactor});
}
