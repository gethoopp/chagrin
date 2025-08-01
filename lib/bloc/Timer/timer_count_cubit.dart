import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpTimerCubit extends Cubit<int> {
  Timer? _timer;

  OtpTimerCubit() : super(0); // awalnya 0 detik

  void startTimer({int seconds = 300}) {
    // 5 menit = 300 detik
    emit(seconds);
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(0);
  }

  void resendTimer() {}

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
