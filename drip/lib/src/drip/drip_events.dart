abstract class DripEvent {
  const DripEvent();
}

abstract class DripAction<DState> extends DripEvent {
  const DripAction();

  Stream<DState> call(DState state);
}

// class GenericStateChangeAction<DState> extends DripEvent {
//   const GenericStateChangeAction(this.newState);

//   final DState newState;

//   Stream<DState> generic() async* {
//     yield newState;
//   }
// }
