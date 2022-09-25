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
        ? StreamBuilder<DState>(
            initialData: drip.initialState,
            stream: drip.stateStream,
            builder: (_, snapshot) {
              return builder(context, snapshot.requireData);
            },
          )
        : AnimatedBuilder(
            animation: drip,
            builder: (_, __) => builder(context, drip.state),
          );
  }
}
