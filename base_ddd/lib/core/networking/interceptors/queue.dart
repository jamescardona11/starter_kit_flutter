import 'dart:async';
import 'dart:collection';

typedef Next<T> = Future<T> Function(T value);

abstract class IQueue<T> {
  Future<T> run(T initialData);

  void add(Next<T> next);

  void addAll(List<Next<T>> nextList);
}

class FutureQueue<T> implements IQueue<T> {
  final Queue<_QueueItem<T>> _nextCycle = Queue();
  // final List<_QueueItem<T>> _nextCycle = [];

  @override
  void add(Next<T> closure) {
    _nextCycle.add(_QueueItem<T>(closure));
  }

  @override
  void addAll(List<Next<T>> closures) {
    _nextCycle.addAll(closures.map((e) => _QueueItem<T>(e)));
  }

  Future<T> _process(T data) {
    final item = _nextCycle.removeFirst();
    final completer = item.completer;
    item.execute(data);

    return completer.future;
  }

  @override
  Future<T> run(T initialData) async {
    T data = initialData;
    final processCompleter = Completer<T>();

    Future.doWhile(() async {
      data = await _process(data);

      if (_nextCycle.isEmpty) {
        processCompleter.complete(data);
      }

      return _nextCycle.isNotEmpty;
    });

    return processCompleter.future;
  }
}

class _QueueItem<T> {
  _QueueItem(
    this.next,
  );

  final Next<T> next;
  final Completer<T> completer = Completer<T>();

  Future<void> execute(T data) async {
    T result;
    try {
      result = await next.call(data);
      completer.complete(result);
      await Future.microtask(() {});
    } catch (e) {
      // todo create a interceptor failure
      // change por completer
      completer.completeError(e);
    }
  }
}
