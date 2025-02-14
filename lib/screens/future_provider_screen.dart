import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/future_provider.dart';


class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jokeAsync = ref.watch(jokeFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("FutureProvider Example")),
      body: Center(
        child: jokeAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err, Stracktrace: $stack"),
          data: (joke) => Text(
            joke,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
