import 'package:flutter/material.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/extensions.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/plan.dart';

class OnboardingAssessment extends StatefulWidget {
  const OnboardingAssessment({Key? key}) : super(key: key);

  @override
  _OnboardingAssessmentState createState() => _OnboardingAssessmentState();
}

class _OnboardingAssessmentState extends State<OnboardingAssessment> {
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
            builder: (_) =>
                const OnboardingAssessment2())); //OnboardingTherapyPlan()
  }

  bool get valid => panic != null;

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: "Basisassessment",
      onPressed: valid ? submit : null,
      showBox: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  "Versuche, dich in die Situation einer MRT-Untersuchung zu versetzen. Wie stark schätzt du deine Angst ein?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          AssessmentSlider(
            title: "Angst",
            value: anxiety,
            onChanged: (data) => setState(() => anxiety = data),
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  "Hattest du schon einmal eine unkontrollierbare Panikattacke oder befindest dich zur Zeit in psychologischer Behandlung?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
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
            ].map<Widget>((l) => Expanded(child: Row(children: l))).toList(),
          ),
        ],
      ),
    );
  }
}

class AssessmentSlider extends StatefulWidget {
  final String title;
  final double value;
  final Function(double) onChanged;
  final double min;
  final double max;

  const AssessmentSlider({
    Key? key,
    this.title = "",
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 10,
  }) : super(key: key);

  @override
  _AssessmentSliderState createState() => _AssessmentSliderState();
}

class _AssessmentSliderState extends State<AssessmentSlider> {
  static const _items = [
    "angstfrei",
    "wenig",
    "moderat",
    "ernst",
    "maximal",
  ];

  Widget buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < _items.length; i++)
          TextButton(
            child: Text(_items[i], style: Theme.of(context).textTheme.caption),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.all(ReampColors.primary),
            ),
            onPressed: () =>
                widget.onChanged((widget.max / (_items.length - 1)) * i),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        SliderTheme(
          data: SliderThemeData(
            trackShape:
                CustomTrackShape(), // ! This reduces the available hit box space for touch inputs at the edge of the slider.
          ),
          child: Slider(
            value: widget.value,
            onChanged: widget.onChanged,
            min: widget.min,
            max: widget.max,
            label: "${widget.value.round()}",
            activeColor: Color.lerp(
                ReampColors.primary, ReampColors.secondary, widget.value / 10),
            inactiveColor: Color.lerp(ReampColors.primary,
                    ReampColors.secondary, widget.value / 10)
                ?.lighten(0.5),
          ),
        ),
        buildRow(context),
      ],
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
