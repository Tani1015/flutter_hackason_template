import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:helper/presentation/widgets/lottie.dart';

class RankingPage extends StatelessWidget {
  const RankingPage._({super.key});

  static const _path = '/ranking';

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => const RankingPage._(),
        settings: const RouteSettings(
          name: _path,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImmediatelyLottie(
            width: screenWidth * 0.4,
            Assets.json.celebrate.path,
          ),
          ImmediatelyLottie(
            width: screenWidth * 0.4,
            Assets.json.celebrate.path,
          ),
        ],
      ),
    );
  }
}
