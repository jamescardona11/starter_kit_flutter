import 'package:flutter/widgets.dart';

import 'i_action.dart';

typedef Dispatch = Future<void> Function(IAction event);

typedef DBuilder<DState> = Widget Function(BuildContext context, DState state);
