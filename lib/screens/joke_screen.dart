import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/joke_provider.dart';

class JokeScreen extends ConsumerWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jokeAsync = ref.watch(jokeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("FutureProvider with Model")),
      body: Center(
        child: jokeAsync.when(
          data: (joke) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(joke!.iconUrl ?? "", width: 80),
              const SizedBox(height: 20),
              Text(joke.value ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}


