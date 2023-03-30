import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/assessment4.dart';
import 'package:reamp/page/onboarding/assessment6.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/privacy.dart';

class OnboardingAssessment5 extends StatefulWidget {
  const OnboardingAssessment5({Key? key}) : super(key: key);

  @override
  State<OnboardingAssessment5> createState() => _OnboardingAssessment5State();
}

class _OnboardingAssessment5State extends State<OnboardingAssessment5> {
  List<String> orderTexts = [
    "Mir helfen Sachinformationen über die Situation.",
    "Mir helfen Atem- und Entspannungsübungen",
    "Mir hilft es die Situation zu üben.",
  ];

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: ReampColors.background,
          shadowColor: ReampColors.background,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReampStateBloc>();
    return SelfAssessLayout(
      pageid: "4",
      child: Column(
        children: [
          /*
      body: CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 30.0),
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
                  "Bitte ordne folgende Aussagen nach deiner persönlichen Präferenz.\nOrdne die Aussage, die am meisten auf dich zutrifft an die Stelle 1.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5.0),

          ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: orderTexts.length,
              proxyDecorator: _proxyDecorator,
              onReorder: (oldIndex, newIndex) => setState(() {
                    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                    final text = orderTexts.removeAt(oldIndex);
                    orderTexts.insert(index, text);
                  }),
              itemBuilder: (context, index) {
                final text = orderTexts[index];
                return buildTexts(index, text);
              }),
          const SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              CupertinoIcons.hand_draw,
              color: Colors.grey,
              size: 30.0,
            ),
            Text(
              "Drücke auf die Elemente und ziehe\nsie dann an die richtige Stelle",
              style: Theme.of(context).textTheme.caption,
            )
          ]),
          const SizedBox(height: 10.0),
          PrimaryButton(
            onPressed: () => {
              bloc.add(ReampStateOrderdListAdded(orderdList: orderTexts)),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OnboardingAssessment6())),
            },
            child: const Text("Weiter"),
          ),
          //const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget buildTexts(int index, String text) => ListTile(
        key: ValueKey(text),
        title: ContentBox(
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),

          /*Container(
          width: 240.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: ReampColors.backgroundBright,
          ),
          child: Center(
            child: Text(
              text,
              style:  Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),*/
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
