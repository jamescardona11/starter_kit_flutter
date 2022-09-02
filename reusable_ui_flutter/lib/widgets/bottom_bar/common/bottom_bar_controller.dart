import 'package:flutter/foundation.dart';

class BottomBarController extends ChangeNotifier {
  int _index = 0;
  bool _visible = true;

  BottomBarController([int index = 0]) {
    _index = index;
  }

  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void changeVisibility() {
    _visible = !_visible;
    notifyListeners();
  }

  int get index => _index;
  bool get visible => _visible;
}
