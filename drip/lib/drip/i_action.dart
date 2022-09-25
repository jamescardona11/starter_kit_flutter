abstract class Action<DState> {
  const Action(this.newState);

  final DState newState;
}

class GenericStateChangeAction<DState> extends Action<DState> {
  const GenericStateChangeAction(super.newState);
}
