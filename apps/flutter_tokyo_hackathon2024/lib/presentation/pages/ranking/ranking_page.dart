import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/ranking/widgets/ranking_list.dart';
import 'package:helper/presentation/widgets/lottie.dart';

class RankingPage extends StatefulWidget {
  const RankingPage._();

  static const _path = '/ranking';

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => const RankingPage._(),
        settings: const RouteSettings(
          name: _path,
        ),
      );

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final celebrateAnimation = ImmediatelyLottie(
      width: screenWidth / 3,
      Assets.json.celebrate.path,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ランキング'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Center(
            child: RankingList(),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                celebrateAnimation,
                celebrateAnimation,
                celebrateAnimation,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
