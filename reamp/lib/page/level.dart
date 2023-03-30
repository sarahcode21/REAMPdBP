import 'package:confetti/confetti.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reamp/bloc/level.dart';
import 'package:reamp/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/model/model.dart';
import 'package:reamp/page/info.dart';
import 'package:reamp/page/onboarding/assessment.dart';
import 'package:reamp/page/video.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({Key? key}) : super(key: key);

  static Widget withBloc({required Level level, required ReampStateBloc bloc}) {
    return BlocProvider(
      create: (_) => LevelBloc(level: level, stateBloc: bloc),
      child: const LevelPage(),
    );
  }

  void showLowTensionDialog(BuildContext context) {
    final bloc = context.read<LevelBloc>();
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Niedriges Angstlevel"),
        content: const Text(
            "Dein Angstlevel ist sehr niedrig. Wenn du möchtest kannst du die weiteren Sitzungen in diesem Level überspringen und das Level vorzeitig abschließen."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(LevelCompletedEarly());
            },
            child: const Text("Kurs abschließen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(LevelContinued());
            },
            child: const Text("Trotzdem fortsetzen"),
          ),
        ],
      ),
    );
  }

  void showHighTensionDialog(BuildContext context) {
    final bloc = context.read<LevelBloc>();
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Hohes Angstlevel"),
        content: const Text(
            "Dein Angstlevel ist sehr hoch. Wir empfehlen dir, dich über MRT-Untersuchungen und MRT-Geräte zu informieren und anschließend dein Training fortzuführen."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(LevelRequestedHints());
            },
            child: const Text("Erklärungen ansehen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(LevelContinued());
            },
            child: const Text("Nein danke"),
          ),
        ],
      ),
    );
  }

  void showCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfettiDialog(
        child: AlertDialog(
          title: const Text("Herzlichen Glückwunsch!"),
          content: const Text("Du hast die Kurseinheit erfolgreich beendet!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Weiter"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LevelBloc>();
    final bloc2 = context.read<ReampStateBloc>();

    //final bloc = context.read<LevelBloc>();
    // bloc.add(SesssionNeededChange(numberOfSessions: 1));
    return BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is LevelDialog) {
            if (state.type == LevelDialogType.lowTension) {
              showLowTensionDialog(context);
            } else if (state.type == LevelDialogType.highTension) {
              showHighTensionDialog(context);
            }
          } else if (state is LevelDone) {
            Navigator.popUntil(context, (route) => route.isFirst);
            if (state.type == LevelDoneType.completed) {
              showCompletedDialog(context);
              bloc2.add(ReampStateLevelCompletedAdded(
                  id: state.level.levelConfigID, result: true));
            } else if (state.type == LevelDoneType.hints) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Info()));
            }
          }
        },
        builder: (BuildContext context, LevelState state) {
          final level = state.level;
          return GeneralLayout(
            title: level.config.name,
            showBackButton: state is LevelBefore,
            child: Builder(
              builder: (context) {
                if (state is LevelBefore) {
                  return _LevelPageBefore(
                    level: level,
                    onSubmit: (tension) => bloc.add(LevelResultAdded(
                      result: LevelResult(
                        time: DateTime.now(),
                        tension: tension,
                      ),
                    )),
                  );
                } else {
                  return _LevelPageAfter(
                    level: level,
                    onSubmit: (tension) => bloc.add(LevelResultAdded(
                      result: LevelResult(
                        time: DateTime.now(),
                        tension: tension,
                      ),
                    )),
                  );
                }
              },
            ),
          );
        });
  }
}

class _LevelPageBefore extends StatefulWidget {
  final Level level;
  final Function(double) onSubmit;
  const _LevelPageBefore(
      {Key? key, required this.level, required this.onSubmit})
      : super(key: key);

  @override
  __LevelPageBeforeState createState() => __LevelPageBeforeState();
}

class __LevelPageBeforeState extends State<_LevelPageBefore> {
  double tension = 5;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final databaseReference = FirebaseDatabase.instance.ref();
    final datajson = state.data.toJson().toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basisassessment",
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          "Um dich effektiv auf deine MRT Untersuchung vorzubereiten bitten wir dich vor und nach jeder Sitzung um eine Selbsteinschätzung deiner Angst. So kannst du dir selbst und auch REAMP deinen Fortschritt erkennbar machen.",
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 8.0),
        Text(
          widget.level.config.assessmentDescription,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 16.0),
        AssessmentSlider(
          title: "Angst",
          value: tension,
          min: 0,
          max: 10,
          onChanged: (data) => setState(() => tension = data),
        ),
        PrimaryButton(
          onPressed: () async {
            final completed = await Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                        builder: (_) => VideoInfo(level: widget.level))) ??
                false;
            if (completed) {
              widget.onSubmit(tension);
            }

            databaseReference.child('Probanden3').set({
              'Proband1': datajson,
              'timestamp': DateTime.now().toString(),
            });
          },
          child: const Text("Bestätigen"),
        ),
      ],
    );
  }
}

class _LevelPageAfter extends StatefulWidget {
  final Level level;
  final Function(double) onSubmit;
  const _LevelPageAfter({Key? key, required this.level, required this.onSubmit})
      : super(key: key);

  @override
  __LevelPageAfterState createState() => __LevelPageAfterState();
}

class __LevelPageAfterState extends State<_LevelPageAfter> {
  double tension = 5;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final databaseReference = FirebaseDatabase.instance.ref();
    final datajson = state.data.toJson().toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basisassessment",
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          "Wie hoch schätzt du deine Angst am Ende der Übung ein?",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 16.0),
        AssessmentSlider(
          title: "Angst",
          value: tension,
          min: 0,
          max: 10,
          onChanged: (data) => setState(() => tension = data),
        ),
        PrimaryButton(
          onPressed: () async {
            widget.onSubmit(tension);
            databaseReference.child('Probanden4').set({
              'Proband1': datajson,
              'timestamp': DateTime.now().toString(),
            });
          },
          child: const Text("Bestätigen"),
        ),
      ],
    );
  }
}

class ConfettiDialog extends StatefulWidget {
  final Widget child;

  const ConfettiDialog({required this.child, Key? key}) : super(key: key);

  @override
  _ConfettiDialogState createState() => _ConfettiDialogState();
}

class _ConfettiDialogState extends State<ConfettiDialog> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Center(
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirection: 0,
            numberOfParticles: 30,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
