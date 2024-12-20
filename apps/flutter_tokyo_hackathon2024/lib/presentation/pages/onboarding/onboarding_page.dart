import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/content/game_content_page.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/game_instruction/game_instruction_page.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/ranking/ranking_page.dart';
import 'package:helper/extensions/context_extension.dart';
import 'package:helper/res/constants.dart';

import '../../../play_game.dart';

class OnboardingPage extends StatefulWidget {

  const OnboardingPage({super.key,});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _push() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlayGame(userName: _nameController.text),
      ),
    );
  }

  void _validate(SnackBar snackBar) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      return;
    }

    _push();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.6 / 2,
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: ネコの尻尾が見えないのでネコの色を変えるか考えてみる
                  Assets.json.cat.lottie(
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'save the cat',
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text('ユーザ名を入力してください'),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: _nameController,
                    style: textTheme.headlineSmall,
                    maxLength: 12,
                    textAlignVertical: TextAlignVertical.center,
                    onTapOutside: (_) => context.hideKeyboard(),
                  ),
                  const SizedBox(height: 40),
                  FilledButton(
                    onPressed: () {
                      _validate(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              kBorderRadius,
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: padding.copyWith(bottom: screenHeight * 0.1),
                          content: Text(
                            '名前を入力してください',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorScheme.error,
                            ),
                          ),
                          backgroundColor: colorScheme.onPrimary,
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(200, 48),
                      backgroundColor: colorScheme.primary,
                    ),
                    child: Text(
                      'ゲームスタート',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).push(
                      GameInstructionPage.route(),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                      backgroundColor: colorScheme.secondary,
                    ),
                    child: Text(
                      'ゲーム説明',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).push(
                      RankingPage.route(),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(200, 48),
                      backgroundColor: colorScheme.tertiary,
                    ),
                    child: Text(
                      'ランキング',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
