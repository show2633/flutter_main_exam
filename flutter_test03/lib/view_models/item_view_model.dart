import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test03/models/item.dart';
import 'package:flutter_test03/repositories/item_repository.dart';

class ItemViewModel extends StateNotifier<List<Item>> {
  final ItemRepository _itemRepository;

  ItemViewModel(this._itemRepository) : super(_itemRepository.itemList);

  void updateName(String itemId, String newName) {
    _itemRepository.updateContentName(itemId, newName);

    state = [
      for (var item in state)
        if (item.itemId == itemId)
          Item(
            itemId: item.itemId,
            contentName: item.contentName,
            count: item.count,
            expDate: item.expDate,
            storageArea: item.storageArea,
          )
        else
          item,
    ];
  }

  void incrementCount(String itemId) {
    state = [
      for (var item in state)
        if (item.itemId == itemId)
          Item(
            itemId: item.itemId,
            contentName: item.contentName,
            count: item.count + 1,
            expDate: item.expDate,
            storageArea: item.storageArea,
          )
        else
          item,
    ];

    _itemRepository.incrementCount(itemId);
  }

  void decrementCount(String itemId) {
    state = [
      for (var item in state)
        if (item.itemId == itemId)
          Item(
            itemId: item.itemId,
            contentName: item.contentName,
            count: item.count - 1,
            expDate: item.expDate,
            storageArea: item.storageArea,
          )
        else
          item,
    ];

    _itemRepository.decrementCount(itemId);
  }
}
