import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test03/views/item_view.dart';
import 'package:flutter_test03/providers/providers.dart';
import 'package:flutter_test03/models/item.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 188, 3)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView> {
  Item? selectedItem;

  bool isEditing = false;
  final TextEditingController controller = TextEditingController();

  void showSubView(Item item) {
    setState(() {
      selectedItem = item;
    });
  }

  void closeSubView() {
    setState(() {
      selectedItem = null;
    });
    isEditing = false;
  }

  void toggleEdit() {
    if (isEditing) {
      final String newName = controller.text;

      ref
          .read(itemViewModelProvider.notifier)
          .updateName(selectedItem?.itemId ?? "", newName);

      selectedItem?.contentName = newName;
    } else {
      controller.text = selectedItem?.contentName ?? "";
    }

    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(itemRepositoryProvider);

    if (value.itemList.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("아이템 리스트")),
        body: Center(child: Text("등록된 아이템이 없습니다.")),
      );
    }
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "냉장",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              if (value.itemList.any((item) => item.storageArea == "냉장"))
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: value.itemList
                        .where((item) => item.storageArea == "냉장")
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return ItemView(
                          item: value.itemList
                              .where((item) => item.storageArea == "냉장")
                              .toList()[index],
                          onTap: () => showSubView(value.itemList
                              .where((item) => item.storageArea == "냉장")
                              .toList()[index]));
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "냉동",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              if (value.itemList.any((item) => item.storageArea == "냉동"))
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: value.itemList
                        .where((item) => item.storageArea == "냉동")
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return ItemView(
                          item: value.itemList
                              .where((item) => item.storageArea == "냉동")
                              .toList()[index],
                          onTap: () => showSubView(value.itemList
                              .where((item) => item.storageArea == "냉동")
                              .toList()[index]));
                    },
                  ),
                ),
              Spacer()
            ],
          ),
        ),
        if (selectedItem != null) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: closeSubView,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 300,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: toggleEdit,
                                  child: isEditing
                                      ? TextField(
                                          controller: controller,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10.0),
                                            border: OutlineInputBorder(),
                                          ),
                                          onSubmitted: (_) {
                                            toggleEdit();
                                          },
                                        )
                                      : Text(
                                          selectedItem?.contentName ?? "",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '유통기한: ${DateFormat('yyyy년 MM월 dd일 HH:mm:ss').format(selectedItem!.expDate)}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '개수: ${selectedItem!.count.toString()}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '보관 장소: ${selectedItem!.storageArea}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Spacer(),
                            FilledButton(
                              onPressed: closeSubView,
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Text(
                                '닫기',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(bottom: 20))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ],
    ));
  }
}
