import 'dart:async';

import 'package:drip/drip/export_drip.dart';
import 'package:flutter/material.dart';

class DripListener<D extends Drip<DState>, DState> extends StatefulWidget {
  /// default constructor
  const DripListener({
    super.key,
    required this.listener,
    required this.child,
  });

  final DListener<DState> listener;
  final Widget child;

  @override
  State<DripListener<D, DState>> createState() =>
      _DripListenerState<D, DState>();
}

class _DripListenerState<D extends Drip<DState>, DState>
    extends State<DripListener<D, DState>> {
  late StreamSubscription<DState> _subscription;
  late DState _previousState;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final drip = DripProvider.of<D>(context);
      _previousState = drip.state;
      _subscribe(drip.stateStream);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe(Stream<DState> stream) {
    _subscription = stream.listen((state) {
      if (_previousState != state) {
        widget.listener.call(context, state);
        _previousState = state;
      }
    });
  }

  void _unsubscribe() {
    _subscription.cancel();
  }
}
