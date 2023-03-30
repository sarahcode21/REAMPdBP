import 'package:flutter/material.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/extensions.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/selbsteinschaetzungInfo.dart';

class Hinweis extends StatefulWidget {
  const Hinweis({Key? key}) : super(key: key);

  @override
  _HinweisState createState() => _HinweisState();
}

class _HinweisState extends State<Hinweis> {
  double anxiety = 5;
  bool? panic;

  Widget _buildPanicWarning(BuildContext context) {
    return AlertDialog(
      title: const Text("Achtung"),
      content: const Text(
          "Falls du schon mal eine Panikattacke erlebt hast, empfehlen wir dir, REAMP nicht "
          "alleine zu nutzen. Du kannst dir eine Begleitperson suchen, die während der Nutzung "
          "auf dich aufpassen kann. Falls du dich aufgrund einer Angststörung in Behandlung "
          "befindest, solltest du vor der Nutzung von REAMP mit deiner behandelnden Person sprechen."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Verstanden"),
        ),
      ],
    );
  }

  void submit() async {
    final bloc = context.read<ReampStateBloc>();
    bloc.add(ReampStateBaseAnxietySet(anxiety: anxiety));

    if (panic ?? false) {
      await showDialog(context: context, builder: _buildPanicWarning);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const SelbstInfo())); //OnboardingTherapyPlan()
  }

  bool get valid => panic != null;

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      showBackButton: true,
      title: "Hinweis",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContentBox(
            child: Column(
              children: [
                Text(
                  "Hattest du schon einmal eine unkontrollierbare Panikattacke oder befindest dich zur Zeit in psychatrischer oder psychotherapeutischer Behandlung?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    [
                      Checkbox(
                        value: panic ?? false,
                        onChanged: (_) => setState(() => panic = true),
                      ),
                      const Text("Ja"),
                    ],
                    [
                      Checkbox(
                        value: !(panic ?? true),
                        onChanged: (_) => setState(() => panic = false),
                      ),
                      const Text("Nein"),
                    ],
                  ]
                      .map<Widget>((l) => Expanded(child: Row(children: l)))
                      .toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: PrimaryButton(
              onPressed: valid ? submit : null,
              child: const Text("Bestätigen"),
            ),
          ),
        ],
      ),
    );
  }
}

/// Original Answer: https://stackoverflow.com/a/64814461
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
