import 'dart:async';

int count = 0;

main() {
  Timer.periodic(const Duration(milliseconds: 500), _callback);
}

void _callback(Timer timer) {
  count++;
  print("------${DateTime.now().toIso8601String()}---------");
  if (count >= 10) {
    timer.cancel();
  }
}
