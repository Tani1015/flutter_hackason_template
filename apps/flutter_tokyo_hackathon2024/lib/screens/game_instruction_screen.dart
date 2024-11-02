import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameInstructionScreen extends StatelessWidget {
  const GameInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゲーム説明'),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ゲームのルール',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ゲームの目的',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('寝ているネコをほっとするように守りましょう！'),
                    const SizedBox(height: 16),
                    Text(
                      '操作方法',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TODO: ネコのAssets
                    const Text('0. ネコがほっとしながら寝ています。'),
                    const Text('1. 寝ているネコに向かって色々な障害物が飛んできます。'),
                    // TODO: 障害物のAssets
                    const Text('2. 障害物は２種類あります。'),
                    // TODO: サンプルPLAY画面
                    const Text('3. 障害物が有機物なら、クリック！無機物なら、スライドで壁を利用！'),
                    const Text('4. ネコを守ることができたら、スコアが加算されます。'),
                    const Text('5. 高いスコアを目指して、ランキングに入りましょう！'),
                    const SizedBox(height: 16),
                    Text(
                      'スコアシステム',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('ここにスコアシステムを記述します。'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
