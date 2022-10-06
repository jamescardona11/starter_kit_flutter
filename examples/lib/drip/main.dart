import 'package:flutter/material.dart';

import 'drip_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: DripExample(),
    );
  }
}

class HomePage extends StatelessWidget {
  /// default constructor
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Text'),
      ),
      body: Container(
        child: Text('HomePage'),
      ),
    );
  }
}

class Foo {
  Foo() {
    print('$this::init');
  }

  String foo() => 'Hello';

  void dispose() => print('$this::dispose');
}

class Bar1 {
  Bar1() {
    print('$this::init');
  }

  String bar1() => 'Hello everyone';

  void dispose() => print('$this::dispose');
}

class Bar2 extends ChangeNotifier {
  Bar2() {
    print('$this::init');
  }

  String bar2() => 'Fall in love with Flutter';

  // void dispose() => print('$this::dispose');

  int count = 0;

  void increment() {
    print('Increment');
    count = count + 1;
    // dispatch(IncrementCount());
    notifyListeners();
  }

  void clear() {
    print('Clear');
    count = 0;
    notifyListeners();
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('GO TO HOME'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return Provider<Bar2>(
                  (context) => Bar2(),
                  child: Home2Page(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Home2Page extends StatelessWidget {
  const Home2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter provider example'),
      ),
      body: Consumer3<Bar2>(
        builder: (BuildContext context, Bar2 c) {
          return Container(
            constraints: const BoxConstraints.expand(),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(c.bar2()),
                  Text('${Provider.of<Bar2>(context, listen: true).count}'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<Bar2>(context).increment();
              },
              child: Icon(Icons.plus_one),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<Bar2>(context).clear();
              },
              child: Icon(Icons.close),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class Consumer3<A extends Object> extends StatelessWidget {
  /// Build a widget tree based on the values from a [Provider].
  final Widget Function(BuildContext context, A a) builder;

  /// Creates a widget that delegates its build to a callback.
  /// The callback will be called with values retrieved from [Provider].
  ///
  /// The [builder] argument must not be null.
  const Consumer3({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      builder(context, Provider.of<A>(context));
}

/// Provides a [value] to all descendants of this Widget. This should
/// generally be a root widget in your App
abstract class Provider<T extends Object> extends StatefulWidget {
  const Provider._({Key? key}) : super(key: key);

  /// Provide a value to all descendants.
  /// The value created on first access by calling [factory].
  ///
  /// The [disposer] will called when [State] of [Provider] is removed from the tree permanently ([State.dispose] called).
  factory Provider(
    T Function(BuildContext) create, {
    Key? key,
    Widget? child,
  }) =>
      _FactoryProvider<T>(
        key: key,
        create: create,
        child: child,
      );

  static T of<T extends Object>(BuildContext context, {bool listen = false}) {
    if (T == dynamic) {
      throw ProviderError();
    }

    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ProviderScope<T>>()
        : (context
            .getElementForInheritedWidgetOfExactType<_ProviderScope<T>>()
            ?.widget as _ProviderScope<T>?);

    if (scope == null) {
      throw ProviderError(T);
    }

    return scope.requireValue;
  }

  @factory
  Provider<T> _copyWithChild(Widget child);
}

/// Retrieve the value from the [Provider] by this [BuildContext].
extension ProviderBuildContextExtension on BuildContext {
  /// Retrieve the value from the [Provider] by this [BuildContext].
  /// See [Provider.of].
  T get<T extends Object>({bool listen = false}) =>
      Provider.of<T>(this, listen: listen);
}

bool _notEquals<T>(T previous, T current) => previous != current;

class _FactoryProvider<T extends Object> extends Provider<T> {
  final T Function(BuildContext) create;
  final Widget? child;

  const _FactoryProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super._(key: key);

  @override
  _FactoryProviderState<T> createState() => _FactoryProviderState<T>();

  @override
  Provider<T> _copyWithChild(Widget child) {
    return Provider<T>(
      create,
      child: child,
      key: key,
    );
  }
}

class _FactoryProviderState<T extends Object>
    extends State<_FactoryProvider<T>> {
  T? value;

  void initValue() {
    if (value == null) {
      value = widget.create(context);
      assert(value != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.child != null);

    return _ProviderScope<T>(
      getValue: () {
        initValue();
        return value!;
      },
      getNullableValue: () => value,
      child: widget.child!,
    );
  }
}

class _ProviderScope<T extends Object> extends InheritedWidget {
  final T Function()? getValue;
  final T? value;

  /// Get value but not require initialization, returns `null` when value is not created.
  /// Only for debug purpose.
  final T? Function() getNullableValue;

  T get requireValue => value ?? getValue!();

  _ProviderScope({
    Key? key,
    this.getValue,
    this.value,
    required Widget child,
    required this.getNullableValue,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ProviderScope<T> oldWidget) {
    return false;
  }
}

/// If the [Provider.of] method fails, this error will be thrown.
///
/// Often, when the `of` method fails, it is difficult to understand why since
/// there can be multiple causes. This error explains those causes so the user
/// can understand and fix the issue.
class ProviderError extends Error {
  /// The type of the class the user tried to retrieve
  final Type? type;

  /// Creates a [ProviderError]
  ProviderError([this.type]);

  @override
  String toString() {
    if (type == null) {
      return '''Error: please specify type instead of using dynamic when calling Provider.of<T>() or context.get<T>() method.''';
    }

    return '''Error: No Provider<$type> found. To fix, please try:
  * Wrapping your MaterialApp with the Provider<$type>.
  * Providing full type information to Provider<$type>, Provider.of<$type> and context.get<$type>() method.
If none of these solutions work, please file a bug at:
https://github.com/hoc081098/flutter_provider/issues/new
      ''';
  }
}
