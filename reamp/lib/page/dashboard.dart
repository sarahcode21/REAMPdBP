import 'package:flutter/material.dart';
import 'package:reamp/core/config/levels.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/model/model.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/course.dart';
import 'package:reamp/page/info.dart';
import 'package:reamp/page/relaxation.dart';
import 'package:reamp/page/settings.dart';
import 'package:reamp/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final results = state.data.assessmentResults;
    double anxietyLevel = state.data.getOverallAnxietyLevel();
    // Methode Dashboardtype aus StateDataKlase if dashboard type is..
    return GeneralLayout(
      title: "Willkommen",
      action: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Settings())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Kurseinheiten",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 16.0),
          _Courses(
            levels: Levels.levels
                .map((e) => state.data.getLevelDataForConfig(e))
                .toList(),
          ),
          const SizedBox(height: 16.0),
          Text(
            "Sonstiges",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 16.0),
          SecondaryButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Relaxation())),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Icon(Icons.ac_unit),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text("Tipps zum Entspannen"),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SecondaryButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Info())),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Icon(Icons.lightbulb),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text("Lehrmaterial zum MRT"),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class _Courses extends StatelessWidget {
  final List<Level> levels;

  const _Courses({required this.levels, Key? key}) : super(key: key);

  bool isEnabled(int index, ReampStateLoaded state) {
    if (state.data.presentationMode) {
      return true;
    } else {
      final Level? previous = index == 0 ? null : levels[index - 1];
      return previous == null || previous.completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    return Column(
      children: [
        for (int i = 0; i < levels.length; i++)
          _CourseTile(
            level: levels[i],
            enabled: isEnabled(i, state),
            prefix: "${i + 1}. ",
          ),
      ],
    );
  }
}

class _CourseTile extends StatelessWidget {
  final Level level;
  final bool enabled;
  final String prefix;

  const _CourseTile(
      {Key? key, required this.level, required this.enabled, this.prefix = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int sessions = level.sessionsCompleted;
    final int needed = level.sessionsNeededForCompletion;
    final bool current = enabled && !(level.completed);

    return GestureDetector(
      onTap: enabled
          ? () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CoursePage(levelConfig: level.config)))
          : null,
      child: ContentBox(
        margin: const EdgeInsets.all(8.0)
            .add(EdgeInsets.symmetric(vertical: current ? 8.0 : 0.0)),
        padding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: current ? 16.0 : 8.0),
        gradient: LinearGradient(
          colors: [ReampColors.primary, ReampColors.background],
          stops: [sessions / needed, sessions / needed],
        ),
        child: SizedBox(
          width: double.infinity,
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "$prefix${level.config.name}",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: current ? 18.0 : null,
                            ),
                      ),
                      SizedBox(height: current ? 8.0 : 4.0),
                      Text(
                        "$sessions von $needed mal ausgeführt",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                if (enabled)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                        level.completed ? Icons.done : Icons.arrow_forward_ios),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
