class DiagnosisEntity {
  final int id;
  final String plant;
  final String disease;
  final String? treatment;
  final String imageUrl;
  final DateTime date;

  const DiagnosisEntity({
    required this.id,
    required this.plant,
    required this.disease,
    this.treatment,
    required this.imageUrl,
    required this.date,
  });
}