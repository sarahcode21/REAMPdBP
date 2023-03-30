import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/assessment4.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/privacy.dart';

class OnboardingAssessment6 extends StatefulWidget {
  const OnboardingAssessment6({Key? key}) : super(key: key);

  @override
  State<OnboardingAssessment6> createState() => _OnboardingAssessment6State();
}

class _OnboardingAssessment6State extends State<OnboardingAssessment6> {
  bool checkedValue = false;
  bool checkedValue2 = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReampStateBloc>();

    return SelfAssessLayout(
      pageid: "4",
      child: Column(
        children: [
          /* body: CustomPaint(
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
                    
                child: Text("4", style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
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
              ],
              ),*/
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "4",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Möchtest du eine der folgende Interventionen für die Angstreduktion ausschließen ?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
          ContentBox(
            margin:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(children: [
              Row(
                children: [
                  const Text("Informationen über das MRT"),
                  const SizedBox(width: 39.0),
                  Checkbox(
                    value: checkedValue,
                    onChanged: (_) =>
                        setState(() => checkedValue = !checkedValue),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  const Text("Atem- und Entspannungsübungen"),
                  Checkbox(
                    value: checkedValue2,
                    onChanged: (_) =>
                        setState(() => checkedValue2 = !checkedValue2),
                  ),
                ],
              ),
            ]),
          ),
          const SizedBox(height: 15.0),
          PrimaryButton(
            onPressed: () {
              if (checkedValue2 == true) {
                bloc.add(ReampStateOrderdListDelete(
                    element: 'Mir helfen Atem- und Entspannungsübungen'));
              }
              if (checkedValue == true) {
                bloc.add(ReampStateOrderdListDelete(
                    element:
                        'Mir helfen Sachinformationen über die Situation.'));
              }
              bloc.add(ReampStateOrderdListDelete(
                  element: 'Mir hilft es die Situation zu üben.'));

              //bloc.add(ReampStateSessionNumber(number: 1));
              bloc.add(
                  ReampStatePresentationMode()); // allows to see videos without timelimits tp reach to get progress
              bloc.add(ReampStateOnboardingFinished());

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OnboardingTherapyPlan()));
            },
            child: const Text("Selbsteinschätzung abschließen"),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget buildTexts(int index, String text) => ListTile(
        key: ValueKey(text),
        title: Container(
          width: 240.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: ReampColors.backgroundBright,
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
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
