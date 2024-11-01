import 'package:flutter/material.dart';
import 'package:helper/res/constants.dart';

//TODO: indicator を追加
class AppWrapper extends StatelessWidget {
  const AppWrapper(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: kMaxScaleFactor,
      minScaleFactor: kMinScaleFactor,
      child: child,
    );
  }
}
