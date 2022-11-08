import 'dart:async';

import 'package:flutter/widgets.dart';

import 'drip_events.dart';

abstract class Drip<DState> extends ChangeNotifier {
  final StreamController<DripEvent> _eventController =
      StreamController<DripEvent>();
  late final StreamController<DState> _stateController;

  late final DState _initialState;
  late DState _state;

  Drip(this._initialState) {
    _state = _initialState;

    _stateController = StreamController<DState>.broadcast();
    _bindStateController();

    // I have the initialState in the DripBuilder
    // Add initialState in controller
    _stateController.add(_initialState);
  }

  Stream<DState> mutableStateOf(DripEvent event) async* {}

  Stream<DState> transform(
    Stream<DripEvent> events,
    Stream<DState> Function(DripEvent event) next,
  ) {
    return events.asyncExpand(next);
  }

  @protected
  set state(DState state) {
    if (_state != state) {
      _state = state;
      notifyListeners();
    }
  }

  @protected
  void emit(DState newState) {
    if (state == newState) return;
    state = newState;
    dispatch(GenericStateChangeAction(newState));
  }

  @protected
  void dispatch(DripEvent event) {
    try {
      onEvent(event);
      _eventController.add(event);
    } catch (err, stackTrace) {
      onError(err, stackTrace);
    }
  }

  @mustCallSuper
  void close() {}

  void onError(Object err, StackTrace? stackTrace) {}

  void onEvent(DripEvent event) {}

  void _bindStateController() {
    transform(
      _eventController.stream,
      (event) {
        if (event is GenericStateChangeAction<DState>) {
          return event.generic().handleError(onError);
        } else if (event is DripAction<DState>) {
          return event.call(state).handleError(onError);
        } else {
          return mutableStateOf(event).handleError(onError);
        }
      },
    ).forEach((DState nextState) {
      if (_stateController.isClosed) return;

      state = nextState;

      _stateController.add(nextState);
    });
  }

  DState get state => _state;
  DState get initialState => _initialState;
  Stream<DState> get stateStream => _stateController.stream;
}
