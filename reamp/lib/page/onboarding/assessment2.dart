import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment3.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/privacy.dart';

class OnboardingAssessment2 extends StatefulWidget {
  const OnboardingAssessment2({Key? key}) : super(key: key);

  @override
  State<OnboardingAssessment2> createState() => _OnboardingAssessment2State();
}

class _OnboardingAssessment2State extends State<OnboardingAssessment2> {
  static const List<String> _onboardingTexts = [
    "Ich verspüre eine innere Anspannung.",
    "Ich mache mir Sorgen wegen meinem MRT-Termin.",
    "Ich mache mir viele Gedanken.",
    "Ich merke, wie mein Puls erhöht ist",
    "Ich verspüre andere Indikatoren für Angst (z.B Magenschmerzen)"
  ];

  Map<int, int> selectedFieldInGroup = {};
  //1:0,2:0,3:0,4:0,5:0

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
    return SelfAssessLayout(
      pageid: "2",
      child: Column(
        children: [
          /* return Scaffold(
      body: CustomPaint(
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

              Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),  
              Text("2", style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                    
            
            
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
                "2",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Kreuze die Box an,die am ehesten auf deine Gefühle der letzten Tage zutrifft",
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
                      children: ["nie", "selten", "oft", "fast immer"]
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
                                            result: (e.key.toDouble() + 1.0)));
                                        if (group <
                                            _onboardingTexts.length - 1) {
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
          /*  ContentBoxPageView(
                controller: controller,
                onPageChanged: (page) => setState(() => selected = page),
                height: MediaQuery.of(context).size.height/5*2,
                pages: [
                  for (final text in _onboardingTexts)...[
                  Column(

                    children:[
                      
                   Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                      children: [
                      Column(
                        children: [
                          Radio(
                            value:1,      
                            groupValue: id,
                            activeColor: ReampColors.primary,
                            onChanged: (val) {
                             setState(() {
                              id = 1;
                              final bloc = context.read<ReampStateBloc>();
                              bloc.add(ReampStateBaseAssesmentAdded(id: text, result: 1.0));
                             });
                            },
                          ),
                          const Text("nie"),
                          ],
                          ),
                          
                          Column(
                            children: [
                                 Radio(
                                    value:2,      
                                    groupValue: id,
                                    activeColor: ReampColors.primary,
                                    onChanged: (val) {
                                    setState(() {
                                      id = 2;
                                      final bloc = context.read<ReampStateBloc>();
                                      bloc.add(ReampStateBaseAssesmentAdded(id: text, result: 2.0));
                                    });
                                    },
                          ),
                            const Text("selten"),
                            ],),

                          Column(
                            children: [
                              Radio(
                                    value:3,      
                                    groupValue: id,
                                    activeColor: ReampColors.primary,
                                    onChanged: (val) {
                                    setState(() {
                                      id = 3;
                                      final bloc = context.read<ReampStateBloc>();
                                      bloc.add(ReampStateBaseAssesmentAdded(id: text, result: 3.0));
                                    });
                                    },
                          ),
                          const Text("oft"),
                            ],),

                          Column(
                            children: [
                                 Radio(
                                    value:4,      
                                    groupValue: id,
                                    activeColor: ReampColors.primary,
                                    onChanged: (val) {
                                    setState(() {
                                      id = 4;
                                      final bloc = context.read<ReampStateBloc>();
                                      bloc.add(ReampStateBaseAssesmentAdded(id: text, result: 4.0));
                                    });
                                    },
                          ),
                          const Text("fast immer"),
                            ],),
                      //.map<Widget>((l) => Expanded(child: Row(children: l))).toList(),
                   ], ),
                   
                 ],
                  ),
                ], ],
              ),*/

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(children: [
              if (//selected == _onboardingTexts.length - 1 &&
                  state.data.assessmentResults.length >= 5) ...[
                PrimaryButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OnboardingAssessment3())),
                  child: const Text("Weiter"),
                )
              ]
              /* else if (selected == _onboardingTexts.length - 1 &&
                  state.data.assessmentResults.length < 5) ...[
                const PrimaryButton(
                  onPressed: null,
                  child: Text("Weiter"),
                ),
              ]*/ else
                const SizedBox(width: 12.0, height: 108),
            ]),
          ),
        ],
      ),
    );
  }
}
