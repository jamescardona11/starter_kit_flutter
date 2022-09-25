import 'package:flutter/widgets.dart';

abstract class Drip<DState> extends ChangeNotifier {
  Drip(DState initialState) : _state = initialState;

  DState _state;

  void dispatch(Action action) {}

  void notify() {}

  @protected
  set state(DState state) {
    if (_state != state) {
      _state = state;
      notifyListeners(); // Review this
    }
  }

  DState get state => _state;
}
