import 'package:flutter/material.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/extensions.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:firebase_database/firebase_database.dart';

class OnboardingAssessment extends StatefulWidget {
  const OnboardingAssessment({Key? key}) : super(key: key);

  @override
  _OnboardingAssessmentState createState() => _OnboardingAssessmentState();
}

class _OnboardingAssessmentState extends State<OnboardingAssessment> {
  double anxiety = 2.5;
  bool? panic;

  bool get valid => panic != null;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReampStateBloc>();
    return SelfAssessLayout(
      pageid: "1",
      child: Column(
        children: [
          /*return Scaffold(
      body: CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 15.0),
              Row(children: [
                Text(
                "Onboarding",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ), 
              const Spacer(),
              Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),
                    
                child: Text("1", style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
              const SizedBox(width: 5.0),
              Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
              const SizedBox(width: 5.0),
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
              const SizedBox(width: 5.0),
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),

              ]),
              const SizedBox(width: 10.0),
              Row(children: [
                  Text(
                "Selbsteinschätzung",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
              IconButton(
                icon: Icon(Icons.info),
                  color: Colors.blue[700],
                  iconSize: 26,
                  onPressed: () {

                  },)
              ],),*/
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Versuche, dich in die Situation einer MRT-Untersuchung zu versetzen. Wie stark schätzt du deine Angst ein?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ContentBox(
            child: AssessmentSlider(
              title: "Angst",
              value: anxiety,
              min: 1,
              max: 4,
              onChanged: (data) => setState(() => anxiety = data),
            ),
          ),
          const SizedBox(height: 75.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: PrimaryButton(
              onPressed: () => {
                bloc.add(ReampStateBaseAnxietySet(anxiety: anxiety)),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OnboardingAssessment2())),
              },
              child: const Text("Bestätigen"),
            ),
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
    required this.min,
    required this.max,
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
    return FittedBox(
      fit: BoxFit.fill,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < _items.length; i++)
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.all(ReampColors.primary),
              ),
              onPressed: () =>
                  widget.onChanged((widget.max / (_items.length - 1)) * i),
              child:
                  Text(_items[i], style: Theme.of(context).textTheme.caption),
            )
        ],
      ),
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

class BackgroundColor extends CustomPainter {
  //final double offset;

  //BackgroundColor(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = ReampColors.primary;
    final rect = Rect.fromLTWH(-24 * (size.width / 18), -(size.height / 1.7),
        (size.height / 2) * 2.0, (size.height / 2) * 1.6);
    canvas.drawOval(rect, painter);
  }

  @override
  bool shouldRepaint(BackgroundColor oldDelegate) {
    return false;
  }
}
