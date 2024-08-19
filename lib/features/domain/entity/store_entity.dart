import 'package:equatable/equatable.dart';
import 'package:smart_garden/features/data/model/store_model/store_model.dart';

class StoreEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;

  const StoreEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
  });

  factory StoreEntity.fromModel(StoreModel model) {
    return StoreEntity(
      id: model.id ?? 0,
      name: model.name ?? '',
      address: model.address ?? '',
      latitude: model.latitude ?? 0,
      longitude: model.longitude ?? 0,
      phoneNumber: model.phoneNumber ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        latitude,
        longitude,
        phoneNumber,
      ];
}
