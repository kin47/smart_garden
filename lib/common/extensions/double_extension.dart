extension DoubleExtension on double? {
  double get celsiusDegree => (this ?? 300.15) - 273.15;
}