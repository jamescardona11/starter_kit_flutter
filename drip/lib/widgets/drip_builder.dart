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
    final drip = DripProvider.of<D>(context);
    return streamListener
        ? _BuilderStream<D, DState>(drip: drip, builder: builder)
        : _BuilderNotifier<D, DState>(drip: drip, builder: builder);
    //builder(context, DripProvider.of<D>(context))
  }
}

class _BuilderNotifier<D extends Drip<DState>, DState> extends StatefulWidget {
  /// default constructor
  const _BuilderNotifier({
    super.key,
    required this.drip,
    required this.builder,
  });

  final Drip<DState> drip;
  final DBuilder<DState> builder;

  @override
  State<_BuilderNotifier<D, DState>> createState() =>
      _BuilderNotifierState<D, DState>();
}

class _BuilderNotifierState<D extends Drip<DState>, DState>
    extends State<_BuilderNotifier<D, DState>> {
  late DState _previousState;
  late DState _state;

  @override
  void initState() {
    _previousState = widget.drip.state;
    _state = widget.drip.state;
    widget.drip.addListener(_onStateChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }

  @override
  void dispose() {
    widget.drip.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (_previousState != widget.drip.state) {
      _previousState = _state;
      _state = widget.drip.state;
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
