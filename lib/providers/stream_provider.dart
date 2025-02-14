import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamCounterProvider = StreamProvider<int>((ref) async* {
  int count = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield count++; // Send new values every second
  }
});