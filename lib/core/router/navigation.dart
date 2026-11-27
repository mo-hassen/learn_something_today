import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

extension SafeNavigation on BuildContext {
  /// Closes the current screen. A screen opened straight from a link has
  /// nothing under it to go back to, so then it goes to the home tab.
  void popOrGoHome() {
    if (canPop()) {
      pop();
    } else {
      go(Routes.home);
    }
  }
}
