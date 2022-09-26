import 'package:drip/drip/export_drip.dart';
import 'package:flutter/material.dart';

class DripBuilder<D extends Drip<DState>, DState> extends StatefulWidget {
  /// default constructor
  const DripBuilder({
    super.key,
    this.streamListener = true,
    required this.builder,
  });

  final bool streamListener;
  final DBuilder<DState> builder;

  @override
  State<DripBuilder<D, DState>> createState() => _DripBuilderState<D, DState>();
}

class _DripBuilderState<D extends Drip<DState>, DState>
    extends State<DripBuilder<D, DState>> {
  late D _drip;

  @override
  void initState() {
    super.initState();
    _drip = DripProvider.of<D>(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.streamListener
        ? StreamBuilder<DState>(
            initialData: _drip.initialState,
            stream: _drip.stateStream,
            builder: (_, snapshot) {
              return widget.builder(context, snapshot.requireData);
            },
          )
        : AnimatedBuilder(
            animation: _drip,
            builder: (_, __) => widget.builder(context, _drip.state),
          );
  }
}
