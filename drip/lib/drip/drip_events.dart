abstract class DripEvent {
  const DripEvent();
}

abstract class DripAction<DState> extends DripEvent {
  const DripAction();

  Stream<DState> call(DripEvent event);
}

class GenericStateChangeAction<DState> extends DripAction<DState> {
  const GenericStateChangeAction(this.newState);

  final DState newState;

  @override
  Stream<DState> call(event) async* {
    yield newState;
  }
}

abstract class GenericActionCall<DState> {
  Stream<DState> mapEventToState(DripEvent event);
}
