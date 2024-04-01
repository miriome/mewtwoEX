import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'countdown_provider.g.dart';

@riverpod
class CountdownNotifier extends _$CountdownNotifier {
  Timer? timer;
  @override
  Duration build(Duration initialDuration, {void Function()? onDone}){
    _startTimer();
    return initialDuration;
    }
    
  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.isNegative) {
        onDone?.call();
        timer.cancel();
      }
      state = state - const Duration(seconds: 1);
      
     });
  }
  
}

