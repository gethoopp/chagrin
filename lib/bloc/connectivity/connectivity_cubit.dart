import 'dart:async';

import 'package:akunku/constant/enum.dart';
import 'package:akunku/repository/connection/base_connection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectionStatus> {
  final BaseConnection connectionService;
  ConnectivityCubit({required this.connectionService})
    : super(ConnectionStatus.undefined);

  StreamSubscription? _subscription;
  StreamSubscription? _connectSubsctiption;
  Timer? timer;

  @override
  Future<void> close() {
    _subscription!.cancel();
    _connectSubsctiption!.cancel();
    timer!.cancel();
    return super.close();
  }

  void initialize() {
    _subscription = connectionService.listen((status) {
      checkConnection();
    });
  }

  void checkConnection() async {
    final canConnect = await connectionService.canConnect();

    if (canConnect) {
      emit(ConnectionStatus.online);
    } else {
      emit(ConnectionStatus.offline);
    }
  }
}
