import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/core/app_images.dart';
import 'package:riverpod_tutorial/screens/home_screen.dart';
import 'package:riverpod_tutorial/screens/login_screen.dart';

import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, authState) async {
      await Future.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      debugPrint("isLoggedIn=>${authState.isLoading}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              authState.isLoggedIn ? const HomeScreen() : const LoginScreen(),
        ),
      );
    });
    return const Scaffold(
      body: Center(
        child: Image(
          height: 150,
          width: 150,
          image: AssetImage(
            AppImages.splashImage,
          ),
        ),
      ),
    );
  }
}
