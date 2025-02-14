import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/auth_provider.dart';
import 'package:riverpod_tutorial/providers/item_notifier.dart';
import 'package:riverpod_tutorial/screens/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(itemProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD with Riverpod'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logoutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Logout"),
            ),
          )
        ],
      ),
      body: itemsList.isEmpty
          ? const Center(child: Text('No Task Found'))
          : ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                final item = itemsList[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          ref
                              .read(itemProvider.notifier)
                              .updateItem(item.id, 'Updated Name');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(itemProvider.notifier).delteItem(item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemProvider.notifier).addItem('New Item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
