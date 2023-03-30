import 'package:flutter/material.dart';
import 'package:reamp/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/config/level.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/level.dart';

class CoursePage extends StatelessWidget {
  final LevelConfig levelConfig;
  const CoursePage({Key? key, required this.levelConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ReampStateBloc>();
    final state = bloc.state as ReampStateLoaded;
    final level = state.data.getLevelDataForConfig(levelConfig);
    //state.data.assessmentResults
    return GeneralLayout(
      title: levelConfig.name,
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.timer,
                  size: 18.0,
                ),
                Text(
                  "${levelConfig.estimatedDuration} min",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(child: Container()),
                Text(
                  "${level.sessionsCompleted} von ${level.sessionsNeededForCompletion} mal ausgeführt",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: Center(
              child: Image.asset(levelConfig.previewAssetPath),
            ),
          ),
          Text(
            "Szenario",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 8.0),
          Text(
            levelConfig.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        LevelPage.withBloc(level: level, bloc: bloc))),
            child: const Text("Sitzung starten"),
          ),
        ],
      ),
    );
  }
}
