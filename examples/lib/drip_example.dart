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
    print('------BUILD => Examples');
    return DripProvider<DripCounter>(
      create: (_) => DripCounter(),
      child: _DripExample(),
    );
  }
}

class _DripExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('------BUILD _Example');
    return Scaffold(
      body: Center(
        child: DripBuilder<DripCounter, int>(
          builder: (context, state) => Text('Counters: $state'),
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
          ],
        ),
      ),
    );
  }
}

class DripCounter extends Drip<int> {
  DripCounter() : super(0);

  void increment() {
    print('Increment');
    emit(state + 1);
    // dispatch(IncrementCount());
  }

  void clear() {
    print('Clear');
    emit(0);
  }

  @override
  Stream<int> mapEventToState(event) async* {
    if (event is IncrementCount) {
      print('DRIP: MapEventToState');
    }
  }
}

class IncrementCount extends DripEvent {}
