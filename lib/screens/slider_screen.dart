import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/slider_provider.dart';

class SliderScreen extends ConsumerWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Slider Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(builder: (context, ref, child) {
            final showPassProvider =
                ref.watch(sliderProvider.select((state) => state.showPassword));
            debugPrint("PasswordChange Provider Call");
            return TextFormField(
              obscureText: showPassProvider,
              decoration: InputDecoration(
                suffix: InkWell(
                  onTap: () {
                    final stateProvider = ref.read(sliderProvider.notifier);
                    stateProvider.state = stateProvider.state
                        .copyWith(showPassword: !showPassProvider);
                  },
                  child: showPassProvider
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
            );
          }),
          const SizedBox(height: 50,),
          Consumer(builder: (context, ref, child) {
            debugPrint("Slider Provider Call");
            final slider =
                ref.watch(sliderProvider.select((state) => state.slider));
            return Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.red.withOpacity(slider),
                ),
                Slider(
                  value:slider,
                  onChanged: (val) {
                    final provider = ref.read(sliderProvider.notifier);
                    provider.state = provider.state.copyWith(slider: val);
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
