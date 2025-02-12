import 'package:flutter_test03/models/item.dart';

class ItemRepository {
  List<Item> itemList = [
    Item(
      itemId: "1",
      contentName: "싱싱한 사과로 만든 애플파이",
      count: 10,
      expDate: DateTime.now().add(Duration(days: 5)),
      storageArea: "냉장",
    ),
    Item(
      itemId: "2",
      contentName: "갓 짜낸 상하목장 우유",
      count: 2,
      expDate: DateTime.now().add(Duration(days: 7)),
      storageArea: "냉장",
    ),
    Item(
      itemId: "3",
      contentName: "연유가 가득 담긴 빙빙바",
      count: 5,
      expDate: DateTime.now().add(Duration(days: 365)),
      storageArea: "냉동",
    ),
    Item(
      itemId: "4",
      contentName: "노릇노릇 구우면 맛있는 동그랑땡",
      count: 12,
      expDate: DateTime.now().add(Duration(days: 10)),
      storageArea: "냉동",
    ),
    Item(
      itemId: "5",
      contentName: "탄산이 한 가득 들어가 있는 콜라",
      count: 8,
      expDate: DateTime.now().add(Duration(days: 30)),
      storageArea: "냉장",
    ),
  ];

  void updateContentName(String itemId, String newName) {
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].itemId == itemId) {
        itemList[i] = itemList[i].copyWith(contentName: newName);
        // DB Update 시키기
      }
    }
  }

  void incrementCount(String itemId) {
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].itemId == itemId) {
        itemList[i] = itemList[i].copyWith(count: itemList[i].count + 1);
        // DB Update 시키기
      }
    }
  }

  void decrementCount(String itemId) {
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].itemId == itemId) {
        if (itemList[i].count > 0) {
          itemList[i] = itemList[i].copyWith(count: itemList[i].count - 1);
          // DB Update 시키기
        }
      }
    }
  }
}
