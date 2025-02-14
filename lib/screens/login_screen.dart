import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/auth_provider.dart';
import 'package:riverpod_tutorial/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("First Time Build");
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username"),
              TextFormField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your username",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your username";
                  }
                  if (value.length < 3) {
                    return "Username must be at least 3 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Password"),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final authState = ref.watch(authProvider);
                  debugPrint("Button Building...");
                  return authState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ref.read(authProvider.notifier).loginUser(
                                      userNameController.text.trim(),
                                      passwordController.text.trim(),
                                    );

                                if (ref.read(authProvider).isLoggedIn) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                } else if (ref
                                        .read(authProvider)
                                        .errorMessage !=
                                    null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          ref.read(authProvider).errorMessage!),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("Login"),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
