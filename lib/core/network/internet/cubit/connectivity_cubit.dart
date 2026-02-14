import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

@injectable
class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  Timer? _debounceTimer;

  ConnectivityCubit() : super(ConnectivityInitial()) {
    _init();
  }

  void _init() {
    checkConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        // Debounce - rapid changes lai handle garcha
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 500), () {
          _updateConnectionStatus(results);
        });
      },
    );
  }

  Future<void> checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e) {
      // Fallback to offline if check fails
      emit(ConnectivityOffline());
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      emit(ConnectivityOffline());
    } else {
      String type = 'Unknown';
      if (results.contains(ConnectivityResult.wifi)) {
        type = 'WiFi';
      } else if (results.contains(ConnectivityResult.mobile)) {
        type = 'Mobile Data';
      } else if (results.contains(ConnectivityResult.ethernet)) {
        type = 'Ethernet';
      }
      emit(ConnectivityOnline(type));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _debounceTimer?.cancel();
    return super.close();
  }
}