import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider:- It can not change it value means immutable
final messageProvider = Provider<String>((ref) {
  return "Hello from Riverpod!";
});

// StateProvider:- It can change it value means mutable
final switchProvider = StateProvider<bool>((ref) => false);

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider's Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final message = ref.watch(messageProvider);
              debugPrint("Message Provider Call");
              return Center(
                child: Text(message),
              );
            },
          ),
          const SizedBox(height: 30),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final isChange = ref.watch(switchProvider);
              debugPrint("Switch Provider Call");
              return Center(
                child: Switch(
                  value: isChange,
                  onChanged: (val) {
                    ref.read(switchProvider.notifier).state = val;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
