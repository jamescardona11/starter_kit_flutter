import 'package:drip/drip/export_drip.dart';
import 'package:flutter/material.dart';

class DripBuilder<D extends Drip<DState>, DState> extends StatelessWidget {
  /// default constructor
  const DripBuilder({
    super.key,
    this.streamListener = true,
    required this.builder,
  });

  final bool streamListener;
  final DBuilder<DState> builder;

  @override
  Widget build(BuildContext context) {
    print('DRIP: build of DripBuilder');
    final drip = DripProvider.of<D>(context);
    return streamListener
        ? _BuilderStream<D, DState>(drip: drip, builder: builder)
        : _BuilderNotifier<D, DState>(drip: drip, builder: builder);
  }
}

class __BuilderNotifier<D extends Drip<DState>, DState>
    extends StatelessWidget {
  const __BuilderNotifier({
    super.key,
    required this.drip,
    required this.builder,
  });

  final Drip<DState> drip;
  final DBuilder<DState> builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: drip,
      builder: (context, child) => builder(context, drip.state),
    );
  }
}

class _BuilderNotifier<D extends Drip<DState>, DState> extends StatefulWidget {
  /// default constructor
  const _BuilderNotifier({
    super.key,
    required this.drip,
    required this.builder,
  });

  final D drip;
  final DBuilder<DState> builder;

  @override
  State<_BuilderNotifier<D, DState>> createState() =>
      _BuilderNotifierState<D, DState>();
}

class _BuilderNotifierState<D extends Drip<DState>, DState>
    extends State<_BuilderNotifier<D, DState>> {
  late DState _previousState;
  late D _drip;

  @override
  void initState() {
    print('DRIP: initState of _BuilderNotifierState');
    _previousState = widget.drip.state;
    _drip = widget.drip;
    _subscribe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('DRIP: build of _BuilderNotifierState');
    return widget.builder(context, _previousState);
    // return AnimatedWidget(
    //   listenable: widget.drip,

    // )
  }

  @override
  void didUpdateWidget(covariant _BuilderNotifier<D, DState> oldWidget) {
    print('DRIP: didUpdateWidget of _BuilderNotifierState');
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drip != widget.drip) {
      _unsubscribe();

      _previousState = widget.drip.state;
      // _state = widget.drip.state;
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    widget.drip.addListener(_onStateChanged);
  }

  void _unsubscribe() {
    widget.drip.removeListener(_onStateChanged);
  }

  void _onStateChanged() {
    if (_previousState != widget.drip.state) {
      _previousState = widget.drip.state;
      setState(() {});
    }
  }
}

class _BuilderStream<D extends Drip<DState>, DState> extends StatefulWidget {
  /// default constructor
  const _BuilderStream({
    super.key,
    required this.drip,
    required this.builder,
  });

  final Drip<DState> drip;
  final DBuilder<DState> builder;

  @override
  State<_BuilderStream<D, DState>> createState() =>
      _BuilderStreamState<D, DState>();
}

class _BuilderStreamState<D extends Drip<DState>, DState>
    extends State<_BuilderStream<D, DState>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('New Page'),
      ),
    );
  }
}
