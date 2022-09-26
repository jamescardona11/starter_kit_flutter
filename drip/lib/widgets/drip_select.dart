import 'package:drip/drip/export_drip.dart';
import 'package:flutter/material.dart';

class DripSelect<D extends Drip<DState>, DState, SelectedState>
    extends StatelessWidget {
  /// default constructor
  const DripSelect({
    super.key,
    required this.builder,
    required this.selector,
    this.streamListener = true,
  });

  final bool streamListener;
  final SBuilder<SelectedState> builder;
  final Selector<DState, SelectedState> selector;

  @override
  Widget build(BuildContext context) {
    final drip = DripProvider.of<D>(context);
    return streamListener
        ? StreamBuilder<DState>(
            initialData: drip.initialState,
            stream: drip.stateStream,
            builder: (_, snapshot) {
              return builder(context, selector(snapshot.requireData));
            },
          )
        : AnimatedBuilder(
            animation: drip,
            builder: (_, __) => builder(context, selector(drip.state)),
          );
  }
}
