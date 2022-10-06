import 'package:drip/drip.dart';
import 'package:flutter/material.dart';

class DripConsumer<D extends Drip<DState>, DState> extends StatefulWidget {
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
  State<DripConsumer<D, DState>> createState() =>
      _DripConsumerState<D, DState>();
}

class _DripConsumerState<D extends Drip<DState>, DState>
    extends State<DripConsumer<D, DState>> {
  late D _drip;

  @override
  void initState() {
    _drip = DripProvider.of<D>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DripListener<D, DState>(
      drip: _drip,
      listener: widget.listener,
      child: DripBuilder<D, DState>(
        drip: _drip,
        builder: widget.builder,
      ),
    );
  }
}