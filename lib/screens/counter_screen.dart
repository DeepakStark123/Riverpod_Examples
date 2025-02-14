import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider:- It can change it value means mutable
final counterProvider = StateProvider<int>((ref) => 0);

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider); // Watches state changes

    return Scaffold(
      appBar: AppBar(title: const Text("StateProvider Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter: $counter", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++; 
              },
              child: const Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}
