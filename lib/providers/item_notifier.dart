import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/model/item_model.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<ItemModel>>((ref){
  return ItemNotifier();
});

class ItemNotifier extends StateNotifier<List<ItemModel>> {
  ItemNotifier() : super([]);

  // Add Items
  void addItem(String name) {
    final newItem = ItemModel(id: DateTime.now().toString(), name: name);
    state.add(newItem);
    state = state.toList();
  }

  // Update Items
  void updateItem(String id, String newName) {
    int foundIndex = state.indexWhere((element) => element.id == id);
    state[foundIndex].name = newName;
    state = state.toList();
  }

  // Delete Items
  void delteItem(ItemModel itemModel) {
    state.removeWhere((item) => item.id == itemModel.id);
    state = state.toList();
  }
}
