import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImmediatelyLottie extends StatefulWidget {
  const ImmediatelyLottie(
    this.name, {
    super.key,
    this.fit,
    this.onCompleted,
    this.width,
    this.height,
  });

  final String name;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final VoidCallback? onCompleted;

  @override
  State<ImmediatelyLottie> createState() => _ImmediatelyLottieState();
}

class _ImmediatelyLottieState extends State<ImmediatelyLottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  void _statusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        widget.onCompleted?.call();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this)
      ..addStatusListener(_statusListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.name,
      fit: widget.fit,
      height: widget.height,
      width: widget.width,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..repeat();
      },
      controller: _controller,
    );
  }
}
