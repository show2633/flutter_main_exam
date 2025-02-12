import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test03/view_models/item_view_model.dart';
import 'package:flutter_test03/repositories/item_repository.dart';
import 'package:flutter_test03/models/item.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

final itemViewModelProvider =
    StateNotifierProvider<ItemViewModel, List<Item>>((ref) {
  final itemRepository = ref.read(itemRepositoryProvider);
  return ItemViewModel(itemRepository);
});
