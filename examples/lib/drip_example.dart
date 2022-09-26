// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drip/drip.dart';
import 'package:drip/drip/drip_events.dart';
import 'package:flutter/material.dart';

class DripExample extends StatelessWidget {
  /// default constructor
  const DripExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DripProvider<DripCounter>(
      create: (_) => DripCounter(),
      child: _DripExample(),
    );
  }
}

class _DripExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DripBuilder<DripCounter, DripCounterState>(
              streamListener: true,
              builder: (context, state) =>
                  Text('CounterDripBuilder: ${state.count}'),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Builder(
              builder: (context) {
                print('BUILDER NormalWith Watch');
                final prd = DripProvider.watch<DripCounter>(context);
                return Text('NormalWatch ${prd.state.count}');
              },
            ),
            SizedBox(height: 20),
            DripSelect<DripCounter, DripCounterState, String>(
              builder: (context, state) {
                print('DripSelect');
                return Text('Select ${state}');
              },
              selector: (state) => state.strNum,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                DripProvider.of<DripCounter>(context).increment();
              },
              child: Icon(Icons.plus_one),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                DripProvider.of<DripCounter>(context).clear();
              },
              child: Icon(Icons.close),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                DripProvider.of<DripCounter>(context).numeric();
              },
              child: Icon(Icons.numbers),
            ),
          ],
        ),
      ),
    );
  }
}

class DripCounter extends Drip<DripCounterState> {
  DripCounter() : super(DripCounterState());

  void increment() {
    print('Increment');
    emit(
      state.copyWith(count: state.count + 1),
    );
    // dispatch(IncrementCount());
  }

  void numeric() {
    print('numeric');
    emit(
      state.copyWith(str: '${state.count}'),
    );
    // dispatch(IncrementCount());
  }

  void clear() {
    print('Clear');
    emit(
      state.copyWith(count: 0),
    );
  }

  @override
  Stream<DripCounterState> mapEventToState(event) async* {
    if (event is IncrementCount) {
      print('DRIP: MapEventToState');
    }
  }
}

class DripCounterState {
  final int count;
  final String strNum;

  DripCounterState({
    this.count = 0,
    this.strNum = '0',
  });

  DripCounterState copyWith({
    int? count,
    String? str,
  }) {
    return DripCounterState(
      count: count ?? this.count,
      strNum: str ?? this.strNum,
    );
  }

  @override
  bool operator ==(covariant DripCounterState other) {
    if (identical(this, other)) return true;

    return other.count == count && other.strNum == strNum;
  }

  @override
  int get hashCode => count.hashCode ^ strNum.hashCode;
}

class IncrementCount extends DripEvent {}
