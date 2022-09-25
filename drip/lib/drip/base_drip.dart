import 'package:flutter/widgets.dart';

import 'i_action.dart';

abstract class Drip<DState> extends ChangeNotifier {
  Drip(DState initialState) : _state = initialState;

  DState _state;

  void dispatch(DState newState) {
    GenericStateChangeAction(newState);
    state = newState;
  }

  void notify() {}

  @protected
  set state(DState state) {
    if (_state != state) {
      _state = state;
      notifyListeners(); // Review this
    }
  }

  @mustCallSuper
  void close() {}

  DState get state => _state;
}
