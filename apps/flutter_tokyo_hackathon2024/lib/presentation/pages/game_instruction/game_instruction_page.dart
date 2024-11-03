import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/game_instruction/hover_instruction_card.dart';

class GameInstructionPage extends StatelessWidget {
  const GameInstructionPage._();

  static const _path = '/game_instruction';

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => const GameInstructionPage._(),
        settings: const RouteSettings(name: _path),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = (screenWidth - 60) / 2 * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゲーム説明'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ゲームのストーリー',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '眠っている猫を見るとホッとしますよね？'
                      '眠っている猫をホッとさせたいですよね？'
                      'それでは、多方面からランダムに飛んでくるさまざまな敵から、眠っている猫を守って下さい！'
                      '敵は、空から落ちてくる鳥のフン、さらには石など、様々なものがあります。'
                      'スライドやクリックを駆使して、猫を敵から守りましょう！',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'キャラクター',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HoverInstructionCard(
                                assetPath: 'assets/json/cat.json',
                                description: 'ほっとしている可愛いネコ。眠れるように守らないと…',
                                size: cardSize,
                              ),
                              const SizedBox(width: 20),
                              HoverInstructionCard(
                                assetPath: 'assets/images/enemies/Bird.png',
                                description: '空の悪魔の鳥！ここはトイレじゃない！',
                                size: cardSize,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HoverInstructionCard(
                                assetPath: 'assets/images/enemies/Poop.png',
                                description: '鳥のフン。空から落ちてきます。',
                                size: cardSize,
                              ),
                              const SizedBox(width: 20),
                              HoverInstructionCard(
                                assetPath: 'assets/images/enemies/stone.png',
                                description: '誰かが投げる石、気をつけよう！',
                                size: cardSize,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '操作方法',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                        'assets/images/instruction/firewall.png',
                        width: cardSize,
                        height: cardSize,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '右矢印キーと左矢印キーでHot壁を動かします。'
                      '飛んでくる障害物からネコをHot壁で守ることができたら+1点です。'
                      'もし、障害物がネコに当たったら-1点になります。'
                      '制限時間内で点数を稼いでください！',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
