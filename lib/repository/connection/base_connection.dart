import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseConnection {
  Future<bool> canConnect();

  StreamSubscription<ConnectivityResult> Function(
    void Function(ConnectivityResult)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  })
  get listen;
}
