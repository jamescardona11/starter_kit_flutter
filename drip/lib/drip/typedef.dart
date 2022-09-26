import 'package:drip/drip/base_drip.dart';
import 'package:flutter/widgets.dart';

import 'drip_events.dart';

typedef Dispatch = Future<void> Function(DripEvent event);

typedef DCreate<D extends Drip> = D Function(BuildContext context);

typedef DBuilder<DState> = Widget Function(BuildContext context, DState state);

typedef DListener<DState> = void Function(BuildContext context, DState state);

typedef Selector<DState, T> = T Function(DState state);

typedef SBuilder<SelectedState> = Widget Function(
  BuildContext context,
  SelectedState data,
);
