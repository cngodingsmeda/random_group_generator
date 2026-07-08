import 'package:flutter/material.dart';

class NoAlwaysScrollableBehavior extends ScrollBehavior {
  const NoAlwaysScrollableBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return const BouncingScrollPhysics();
    } else {
      return const ClampingScrollPhysics();
    }
  }
}
