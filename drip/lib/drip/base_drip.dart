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
    // _stateController.add(_initialState);
  }

  void emit(DState newState) {
    if (state == newState) return;
    state = newState;
    dispatch(GenericStateChangeAction(newState));
  }

  void dispatch(DripEvent event) {
    try {
      onEvent(event);
      _eventController.add(event);
    } catch (err, stackTrace) {
      onError(err, stackTrace);
    }
  }

  Stream<DState> mapEventToState(DripEvent event) async* {}

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

  @mustCallSuper
  void close() {}

  void onError(Object err, StackTrace? stackTrace) {}

  void onEvent(DripEvent event) {}

  void _bindStateController() {
    transform(
      _eventController.stream,
      (event) {
        if (event is DripAction<DState>) {
          return event.call(event).handleError(onError);
        } else {
          return mapEventToState(event).handleError(onError);
        }
      },
    ).forEach((DState nextState) {
      if (_stateController.isClosed) return;

      _stateController.add(nextState);
    });
  }

  DState get state => _state;
  DState get initialState => _initialState;
  Stream<DState> get stateStream => _stateController.stream;
}
