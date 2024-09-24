import 'package:smart_garden/features/data/model/diagnosis_model/diagnosis_model.dart';

class DiagnosisEntity {
  final int id;
  final String plant;
  final String disease;
  final String? treatment;
  final String imageUrl;
  final DateTime date;
  final String? reference;

  const DiagnosisEntity({
    required this.id,
    required this.plant,
    required this.disease,
    this.treatment,
    required this.imageUrl,
    required this.date,
    this.reference,
  });

  factory DiagnosisEntity.fromModel(DiagnosisModel model) {
    return DiagnosisEntity(
      id: model.id ?? 0,
      plant: model.plant ?? '',
      disease: model.disease ?? '',
      treatment: model.treatment ?? '',
      imageUrl: model.image ?? '',
      date: model.sendAt ?? DateTime.now(),
      reference: model.reference,
    );
  }
}