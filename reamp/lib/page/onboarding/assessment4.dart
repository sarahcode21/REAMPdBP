import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment3.dart';
import 'package:reamp/page/onboarding/assessment5.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/privacy.dart';

class OnboardingAssessment4 extends StatefulWidget {
  const OnboardingAssessment4({Key? key}) : super(key: key);

  @override
  State<OnboardingAssessment4> createState() => _OnboardingAssessment4State();
}

class _OnboardingAssessment4State extends State<OnboardingAssessment4> {
  static const List<String> _onboardingTexts = [
    "Ich habe Angst vor plötzlichen oder lauten Geräuschen(z.B Donner).",
    "Ich bin unsicher, da ich nicht weiß, was mich während der Untersuchung erwartet",
    "Ich habe Angst in engen Räumen, bzw bei eingeschränkter Bewegungsfreiheit",
    "Ich habe Angst vor dem Untersuchungsgerät.",
    "Ich habe Angst vor der Diagnose"
  ];

  Map<int, int> selectedFieldInGroup = {};

  int selected = 0;
  double scrollingOffset = 0;
  final PageController controller = PageController(viewportFraction: 0.8);
  bool? panic;
  int id = 1;
  int idplace = 0;

  get value => null;

  @override
  void initState() {
    super.initState();
    controller.addListener(
        () => setState(() => scrollingOffset = controller.page ?? 0));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReampStateBloc>();
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    List<String>? _checked = [];

    return SelfAssessLayout(
      pageid: "3",
      child: Column(children: [
        /*body: CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(width: 5.0),
              Row(children: [
                Text(
                "Onboarding",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ), 
              const Spacer(),
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
              Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),
                    
                child: Text("3", style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
              const SizedBox(width: 5.0),
             
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),

              ]),
              
              const SizedBox(width: 5.0),
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
              "3",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                "Wie sehr trifft folgende Aussage auf\ndich zu ?",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
        ContentBoxPageView(
          controller: controller,
          onPageChanged: (page) => setState(() => selected = page),
          height: MediaQuery.of(context).size.height / 5 * 2,
          pages: [
            for (int group = 0; group < _onboardingTexts.length; group++)
              Column(
                children: [
                  Text(
                    _onboardingTexts[group],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                    children: ["Gar nicht", "wenig", "ziemlich", "stark"]
                        .asMap()
                        .entries
                        .map(
                          (e) => Column(
                            children: [
                              Radio(
                                  value: e.key,
                                  groupValue: selectedFieldInGroup[group],
                                  activeColor: ReampColors.primary,
                                  onChanged: (id) {
                                    setState(() {
                                      selectedFieldInGroup[group] = e.key;
                                      final bloc =
                                          context.read<ReampStateBloc>();
                                      bloc.add(ReampStateBaseAssesmentAdded(
                                          id: _onboardingTexts[group],
                                          result: (e.key.toDouble() + 1)));
                                      if (group < _onboardingTexts.length - 1) {
                                        controller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn);
                                      }
                                    });
                                  }),
                              Text(e.value),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(children: [
            if (//selected == _onboardingTexts.length - 1 &&
                state.data.assessmentResults.length == 10) ...[
              PrimaryButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const OnboardingAssessment5())),
                child: const Text("Weiter"),
              )
            ] 
            /*else if (selected == _onboardingTexts.length - 1 &&
                state.data.assessmentResults.length < 10) ...[
              const PrimaryButton(
                onPressed: null,
                child: Text("Weiter"),
              ),
            ] */else
              const SizedBox(width: 12.0, height: 108),
          ]),
        ),
      ]),
    );
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
