import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/common/constants/location_constants.dart';
import 'package:smart_garden/common/extensions/index.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';
import 'package:smart_garden/features/domain/repository/location_repository.dart';
import 'package:location/location.dart';

part 'home_admin_event.dart';

part 'home_admin_state.dart';

part 'home_admin_bloc.freezed.dart';

part 'home_admin_bloc.g.dart';

@injectable
class HomeAdminBloc extends BaseBloc<HomeAdminEvent, HomeAdminState> {
  HomeAdminBloc(
    this._authRepository,
    this._locationRepository,
  ) : super(HomeAdminState.init()) {
    on<HomeAdminEvent>((event, emit) async {
      await event.when(
        init: (userEntity) => init(emit, userEntity),
        getMyLocation: (location) => getMyLocation(emit, location),
        updateBlindPersonLocation: (location) =>
            updateBlindPersonLocation(emit, location),
        getBlindPersonLocation: () => getBlindPersonLocation(emit),
        signOut: () => signOut(emit),
      );
    });
  }

  final AuthRepository _authRepository;
  final LocationRepository _locationRepository;

  Future init(Emitter<HomeAdminState> emit, UserEntity userEntity) async {
    emit(state.copyWith(userEntity: userEntity));

    await _initUserLocation();
    await _initAdminLocation();
  }

  Future<void> _initUserLocation() async {
    final FirebaseFirestore firebase = FirebaseFirestore.instance;
    final user = await firebase
        .collection('users')
        .where('email', isEqualTo: state.userEntity?.email.userEmail)
        .get();
    if (user.docs.isEmpty) {
      throw Exception('User not found');
    }

    final snapshots = firebase
        .collection('users')
        .doc(user.docs[0].id)
        .collection('locations')
        .orderBy('time', descending: true)
        .snapshots();

    snapshots.listen((event) async {
      if (event.docs.isNotEmpty) {
        final data = event.docs.first.data();
        add(HomeAdminEvent.updateBlindPersonLocation(
          blindPersonLocation:
              LatLng(data['latitude'] as double, data['longitude'] as double),
        ));
      }
    });
  }

  Future<void> _initAdminLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      add(HomeAdminEvent.getMyLocation(
        myLocation: LatLng(
            currentLocation.latitude ?? 0, currentLocation.longitude ?? 0),
      ));
    });
  }

  Future getMyLocation(Emitter<HomeAdminState> emit, LatLng location) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        myLocation: location,
      ),
    );
  }

  Future getBlindPersonLocation(Emitter<HomeAdminState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _locationRepository.getBlindPersonLocation(
      adminEmail: state.userEntity?.email ?? '',
    );
    result.fold(
      (l) => emit(state.copyWith(status: BaseStateStatus.failed)),
      (r) {
        emit(
          state.copyWith(
            status: BaseStateStatus.idle,
            blindPersonLocation: LatLng(r.latitude, r.longitude),
          ),
        );
      },
    );
  }

  Future updateBlindPersonLocation(
      Emitter<HomeAdminState> emit, LatLng location) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        blindPersonLocation: location,
      ),
    );
  }

  Future signOut(Emitter<HomeAdminState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _authRepository.signOut();
    result.fold(
      (l) => emit(state.copyWith(status: BaseStateStatus.failed)),
      (r) {
        if (r == true) {
          emit(state.copyWith(status: BaseStateStatus.logout));
        } else {
          emit(state.copyWith(status: BaseStateStatus.failed));
        }
      },
    );
  }
}
