import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/stream_provider.dart';

/*
B) StreamProvider (Real-time Data)
Used for real-time updates, like Firebase Firestore or WebSockets.

Example: Stream Counter
*/

class StreamCounterScreen extends ConsumerWidget {
  const StreamCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterAsync = ref.watch(streamCounterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("StreamProvider Example")),
      body: Center(
        child: counterAsync.when(
          data: (count) =>
              Text("Count: $count", style: const TextStyle(fontSize: 24)),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
