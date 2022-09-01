import 'package:flutter/material.dart';

class KikBottomBar extends StatefulWidget {
  const KikBottomBar({
    super.key,
    this.items = const [],
    this.selectedIndex = 0,
    required this.onItemSelected,
  });

  final List<KikItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  @override
  State<KikBottomBar> createState() => _KikBottomBarState();
}

class _KikBottomBarState extends State<KikBottomBar> {
  late final ValueNotifier<int> _index;

  @override
  void initState() {
    _index = ValueNotifier<int>(widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.items.map((item) {
            var index = widget.items.indexOf(item);
            return InkWell(
              onTap: () {
                _index.value = index;
                widget.onItemSelected?.call(index);
              },
              child: ValueListenableBuilder<int>(
                valueListenable: _index,
                builder: (_, value, __) => _KikItem(
                  item: item,
                  isSelected: index == value,
                  length: widget.items.length,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class KikItem {
  Color textColor;
  String title;
  Widget icon;

  KikItem({
    required this.textColor,
    required this.title,
    required this.icon,
  });
}

class _KikItem extends StatelessWidget {
  const _KikItem({
    Key? key,
    required this.item,
    required this.length,
    this.isSelected = false,
  }) : super(key: key);

  final KikItem item;
  final bool isSelected;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / length,
      height: kBottomNavigationBarHeight,
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        duration: const Duration(milliseconds: 250),
        child: isSelected
            ? Text(
                item.title,
                style: TextStyle(
                  color: item.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : item.icon,
      ),
    );
  }
}
