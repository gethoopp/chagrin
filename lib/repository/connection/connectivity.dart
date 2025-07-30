import 'dart:async';

import 'package:akunku/repository/connection/base_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Connection implements BaseConnection {
  final Connectivity connectivity;

  Connection({required this.connectivity});

  @override
  Future<bool> canConnect() async {
    final List<ConnectivityResult> connectivityResult = await connectivity
        .checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult.isEmpty ||
        connectivityResult == ConnectivityResult.none) {
      return false;
    }

    return true;
  }

  @override
  StreamSubscription<ConnectivityResult> Function(
    void Function(ConnectivityResult)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  })
  get listen =>
      (onData, {onError, onDone, cancelOnError}) => connectivity
          .onConnectivityChanged
          .expand((results) => results)
          .listen(
            onData,
            onError: onError,
            onDone: onDone,
            cancelOnError: cancelOnError,
          );
}
