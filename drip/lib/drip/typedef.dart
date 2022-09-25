import 'package:flutter/widgets.dart';

import 'drip_events.dart';

typedef Dispatch = Future<void> Function(DripEvent event);

typedef DBuilder<DState> = Widget Function(BuildContext context, DState state);

typedef Selector<DState, S> = S Function(DState state);
