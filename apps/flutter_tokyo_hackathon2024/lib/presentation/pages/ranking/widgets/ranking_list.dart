import 'package:firebase_helper/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/models/game_score/game_score_model.dart';
import 'package:helper/logger/logger.dart';

class RankingList extends StatefulWidget {
  const RankingList({super.key});

  @override
  State<StatefulWidget> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  FirebaseFirestoreHelper get _firestoreHelper =>
      FirebaseFirestoreHelper.instance;

  Future<List<GameScoreModel>> _getRankingList() async {
    final rankings = List<GameScoreModel>.of([]);

    try {
      final documents = await _firestoreHelper.collectionGroup(
        collectionPath: GameScoreModel.collectionPath,
        queryBuilder: (query) => query.limit(3).orderBy(
              'score',
              descending: true,
            ),
        decode: GameScoreModel.fromJson,
      );

      for (final doc in documents) {
        if (doc.exists && doc.data != null) {
          rankings.add(doc.data!);
        }
      }
    } on Exception catch (e) {
      logger.shout(e);
    }

    logger.info(rankings);

    return rankings;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getRankingList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final textStyle = textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
    );

    return FutureBuilder(
      future: _getRankingList(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          const Center(
            child: Text('取得エラーが発生しました'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        }

        if (snapshot.hasData) {
          final rankings = snapshot.data;

          if (rankings == null || rankings.isEmpty) {
            return Center(
              child: Text(
                'ランキングデータがありません',
                style: textStyle,
              ),
            );
          }

          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final ranking = rankings[index];

              return _RankingTile(
                title: ranking.score.toString(),
                subTitle: ranking.userName,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 24,
            ),
            itemCount: rankings.length,
          );
        }

        return Center(
          child: Text(
            'ランキングがありません',
            style: textStyle,
          ),
        );
      },
    );
  }
}

class _RankingTile extends StatelessWidget {
  const _RankingTile({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title pt',
          style: textTheme.headlineSmall!.copyWith(
            fontSize: 40,
            color: colorScheme.primary.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 32),
        Text(
          subTitle,
          style: textTheme.headlineSmall!.copyWith(
            fontSize: 32,
            color: colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}
