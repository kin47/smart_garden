import 'package:smart_garden/features/data/model/kit_model/kit_model.dart';

class KitEntity {
  final int id;
  final String name;
  final String password;
  final bool isAutoLight;
  final bool isAutoPump;
  final int lightThreshold;
  final int pumpThreshold;

  KitEntity({
    required this.id,
    required this.name,
    required this.password,
    this.isAutoLight = false,
    this.isAutoPump = false,
    this.lightThreshold = 0,
    this.pumpThreshold = 0,
  });

  factory KitEntity.fromModel(KitModel model) {
    return KitEntity(
      id: model.id ?? 0,
      name: model.name ?? '',
      password: model.password ?? '',
      isAutoLight: model.isAutoLight ?? false,
      isAutoPump: model.isAutoPump ?? false,
      lightThreshold: model.lightThreshold ?? 0,
      pumpThreshold: model.pumpThreshold ?? 0,
    );
  }
}
