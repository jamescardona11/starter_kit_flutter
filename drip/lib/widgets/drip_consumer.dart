import 'package:drip/drip.dart';
import 'package:flutter/material.dart';

class DripConsumer<D extends Drip<DState>, DState> extends StatelessWidget {
  /// default constructor
  const DripConsumer({
    super.key,
    required this.builder,
    required this.listener,
    this.streamListener = true,
  });

  final DBuilder<DState> builder;
  final DListener<DState> listener;
  final bool streamListener;

  @override
  Widget build(BuildContext context) {
    return DripListener<D, DState>(
      listener: listener,
      child: DripBuilder<D, DState>(
        builder: builder,
      ),
    );
  }
}
