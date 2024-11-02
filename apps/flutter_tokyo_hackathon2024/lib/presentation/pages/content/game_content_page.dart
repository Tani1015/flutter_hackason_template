import 'package:firebase_helper/converters/date_time_converter.dart';
import 'package:firebase_helper/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/models/game_score/game_score_model.dart';
import 'package:helper/logger/logger.dart';

class GameContentPage extends StatefulWidget {
  const GameContentPage._({
    required this.userName,
  });

  final String userName;

  static const _path = '/game_content';

  static Route<void> route({
    required String userName,
  }) =>
      MaterialPageRoute(
        builder: (_) => GameContentPage._(userName: userName),
        settings: const RouteSettings(
          name: _path,
        ),
      );

  @override
  State<StatefulWidget> createState() => _GameContentPageState();
}

class _GameContentPageState extends State<GameContentPage> {
  FirebaseFirestoreHelper get _firebaseHelper =>
      FirebaseFirestoreHelper.instance;

  Future<void> _saveGameScore({
    required int score,
  }) async {
    final data = GameScoreModel(
      userName: widget.userName,
      score: score,
    );

    try {
      await _firebaseHelper.set(
        documentPath: GameScoreModel.documentPath(
          widget.userName,
        ),
        data: data.toJson(),
        setOptions: SetOptions(merge: true),
      );
    } on Exception catch (e) {
      logger.warning(e);
    }

    if (context.mounted) {
      _pop();
    }
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '猫をほっとさせてください',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            await _saveGameScore(score: 12);
          },
          child: const Text('save'),
        ),
      ),
    );
  }
}
