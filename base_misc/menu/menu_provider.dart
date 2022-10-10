import 'package:flutter/material.dart';

class MenuItemsProvider extends ChangeNotifier {
  MenuItemsProvider([this._state = _defaultMenuItemsList]);

  List<MenuItemUIM> _state;

  void toggle(String route) {
    _state = [
      for (final item in _state)
        if (item.route == route)
          item.copyWith(isSelected: true)
        else
          item.copyWith(isSelected: false)
    ];

    notifyListeners();
  }

  void changeTab(int index) => toggle(_state[index].route);

  int activeIndex() {
    return _state.indexWhere((item) => item.isSelected);
  }

  List<MenuItemUIM> get currentState => _state;
}

const _defaultMenuItemsList = [
  MenuItemUIM(
    label: 'Home',
    route: '/home',
    icon: Icons.home,
  ),
  MenuItemUIM(
    label: 'Other',
    route: '/other',
    icon: Icons.abc,
    isSpecial: true,
    isSelected: true,
  ),
  MenuItemUIM(
    label: 'Other2',
    route: '/other2',
    icon: Icons.favorite,
  ),
];
