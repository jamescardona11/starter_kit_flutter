import 'package:flutter/widgets.dart';

import 'base_drip.dart';
import 'typedef.dart';

typedef DCreate<D extends Drip> = D Function(BuildContext context);

class DripProvider<D extends Drip> extends StatefulWidget {
  const DripProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super(key: key);

  final DCreate<D> create;
  final Widget child;

  @override
  State<DripProvider<D>> createState() => _DripProviderState<D>();

  static D of<D extends Drip>(BuildContext context, {bool listen = false}) {
    if (D == dynamic) {
      throw ProviderError();
    }

    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<_DripProviderIW<D>>()
        : (context
            .getElementForInheritedWidgetOfExactType<_DripProviderIW<D>>()
            ?.widget as _DripProviderIW<D>?);

    if (provider == null) {
      throw ProviderError(D);
    }

    return provider.drip;
  }

  static D read<D extends Drip>(BuildContext context) {
    return DripProvider.of<D>(context);
  }
}

class _DripProviderState<D extends Drip> extends State<DripProvider<D>> {
  late D drip;

  @override
  void initState() {
    super.initState();
    drip = widget.create(context);
  }

  @override
  Widget build(BuildContext context) {
    print('DRIP: build of DripProvider');
    return _DripProviderIW(
      drip: drip,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    drip.close();
    super.dispose();
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
  bool updateShouldNotify(covariant _DripProviderIW<D> oldWidget) => false;
}

class _DripSelector<DState> extends InheritedModel<Selector> {
  const _DripSelector({
    super.key,
    required this.state,
    required super.child,
  });

  final DState state;

  @override
  bool updateShouldNotify(covariant _DripSelector<DState> oldWidget) {
    return state != oldWidget.state;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant _DripSelector<DState> oldWidget, Set<Selector> dependencies) {
    return dependencies.any(
      (selector) => selector(oldWidget.state) != selector(state),
    );
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
