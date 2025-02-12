import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test03/models/item.dart';
import 'package:flutter_test03/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test03/views/circle_button.dart';

class ItemView extends ConsumerStatefulWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemView({super.key, required this.item, required this.onTap});

  @override
  ConsumerState<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends ConsumerState<ItemView> {
  @override
  Widget build(BuildContext context) {
    final itemViewModel = ref.watch(itemViewModelProvider);

    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: widget.onTap,
            child: SizedBox(
                width: 200,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.contentName),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('yyyy년 MM월 dd일 HH:mm:ss')
                              .format(widget.item.expDate),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
          ),
          CircleButton(
            text: "-",
            onPressed: () {
              ref
                  .read(itemViewModelProvider.notifier)
                  .decrementCount(widget.item.itemId);
            },
          ),
          SizedBox(
            width: 30,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  itemViewModel
                      .firstWhere((item) => item.itemId == widget.item.itemId)
                      .count
                      .toString(),
                )),
          ),
          CircleButton(
            text: "+",
            onPressed: () {
              ref
                  .read(itemViewModelProvider.notifier)
                  .incrementCount(widget.item.itemId);
            },
          ),
        ],
      ),
    );
  }
}
