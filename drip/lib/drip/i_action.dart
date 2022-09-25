abstract class IAction<DState> {
  const IAction(this.newState);

  final DState newState;
}

class GenericStateChangeAction<DState> extends IAction<DState> {
  const GenericStateChangeAction(super.newState);
}
