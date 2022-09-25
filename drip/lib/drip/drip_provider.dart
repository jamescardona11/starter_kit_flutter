import 'package:flutter/widgets.dart';

import 'base_drip.dart';

class DripProvider<D extends Drip<DState>, DState> extends StatefulWidget {
  const DripProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super(key: key);

  final D create;
  final Widget child;

  @override
  State<DripProvider<D, DState>> createState() =>
      _DripProviderState<D, DState>();

  static D of<D extends Drip>(BuildContext context, {bool listen = false}) {
    if (D == dynamic) {
      // throw ProviderError();
    }

    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_DripProviderIW<D>>()
        : (context
            .getElementForInheritedWidgetOfExactType<_DripProviderIW<D>>()
            ?.widget as _DripProviderIW<D>?);

    if (scope == null) {
      // throw ProviderError(T);
    }

    return scope!.drip;
  }

  // static R read<R extends DripNotifier>(BuildContext context) {}
}

class _DripProviderState<D extends Drip<DState>, DState>
    extends State<DripProvider<D, DState>> {
  @override
  Widget build(BuildContext context) {
    return _DripProviderIW(
      drip: widget.create,
      child: widget.child,
    );
  }
}

class _DripProviderIW<D extends Drip> extends InheritedWidget {
  const _DripProviderIW({
    super.key,
    required super.child,
    required this.drip,
  });

  final D drip;

  @override
  bool updateShouldNotify(covariant _DripProviderIW<D> oldWidget) {
    return oldWidget.drip != drip;
  }
}

class ProviderError extends Error {
  /// The type of the class the user tried to retrieve
  final Type? type;

  /// Creates a [ProviderError]
  ProviderError([this.type]);

  @override
  String toString() {
    if (type == null) {
      return '''Error: please specify type instead of using dynamic when calling DripProvider.of<T>() or context.get<T>() method.''';
    }

    return '''Error: No Provider<$type> found. To fix, please try:
              * Wrapping your MaterialApp with the DripProvider<$type>.
              * Providing full type information to DripProvider<$type>, DripProvider.of<$type> and context.get<$type>() method.
          ''';
  }
}
