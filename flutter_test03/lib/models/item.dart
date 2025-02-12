class Item {
  String itemId = "";
  String contentName = "";
  int count = 0;
  DateTime expDate = DateTime.now();
  String storageArea = "";

  Item(
      {required this.itemId,
      required this.contentName,
      required this.count,
      required this.expDate,
      required this.storageArea});

  Item copyWith({
    String? itemId,
    String? contentName,
    int? count,
    DateTime? expDate,
    String? storageArea,
  }) {
    return Item(
      itemId: itemId ?? this.itemId,
      contentName: contentName ?? this.contentName,
      count: count ?? this.count,
      expDate: expDate ?? this.expDate,
      storageArea: storageArea ?? this.storageArea,
    );
  }
}
