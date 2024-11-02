import 'package:flutter/material.dart';
import 'package:helper/res/app_theme.dart';
import 'game_instruction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ほっとしているネコを守れ',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '名前を入力してください',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('名前を入力してください')),
                    );
                    return;
                  }
                  // TODO: ゲーム画面へ移動
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: theme.colorScheme.primary,
                ),
                child: Text(
                  'ゲームスタート',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameInstructionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: theme.colorScheme.secondary,
                ),
                child: Text(
                  'ゲーム説明',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // TODO: ランキング画面へ移動
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: theme.colorScheme.tertiary,
                ),
                child: Text(
                  'ランキング',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
