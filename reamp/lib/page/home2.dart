import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/levels.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/page/Checkbox1.dart';
import 'package:reamp/page/course.dart';
import 'package:reamp/page/info.dart';
import 'package:reamp/page/notification_api.dart';
import 'package:reamp/page/relaxation.dart';
import 'package:reamp/page/settings.dart';
import 'package:reamp/page/vrTraining.dart';

class homescreen2 extends StatefulWidget {
  const homescreen2({Key? key}) : super(key: key);

  @override
  State<homescreen2> createState() => _homescreen2State();
}

class _homescreen2State extends State<homescreen2> {
  bool checkedValue = false;
  bool checkedValue2 = false;
  bool showAtem = false;
  bool showLehrmaterial = false;
  int vrElementeNum = 0;
  double? statusbar;
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();

    listenNotfications();

    //showDialog(context: context, builder: _buildPanicWarning);

    /*var state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
   double anxietyLevel= state.data.getOverallAnxietyLevel();
   print(anxietyLevel/10);
   // anxietyLevel = 1.6;

   if(anxietyLevel<1.5){
     //sessioncompleted=1;
     vrElementeNum = 3;

   }

  if(anxietyLevel >1.5 && anxietyLevel <2 ){
     //sessioncompleted=1;
     vrElementeNum = 0;
     if(state.data.therapieElemente.isEmpty== false){
       if(state.data.therapieElemente.first =="Mir helfen Atem- und Entspannungsübungen"){
         showAtem = true;
       }

       if(state.data.therapieElemente.first =="Mir helfen Atem- und Entspannungsübungen"){
         showLehrmaterial = true;
       }
     }*/
  }

  void _onClickedNotifications(String? payload) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (context) => VorabPage()),
    );
  }

  void listenNotfications() {
    NotificationAPI.onNotifications.stream.listen(_onClickedNotifications);
  }

  Widget _buildPanicWarning(BuildContext context) {
    return AlertDialog(
      title: const Text("Deine Kurseinheiten"),
      content: const Text(
          "Deine personalisierten Kurseinheiten helfen dir dich auf deinen MRT-Termin vorzubereiten. "
          "Du kannst dabei frei wählen, welche Kurseinheiten du zuerst machen möchtest. "
          "In der Navigationsleiste unten findest du zusätzlich alle unsere Kurseinheiten, die helfen können Angst vor einer MRT-Untersuchung zu überwinden."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Verstanden"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration.zero, () => showAlert(context));

    const List<String> _checkboxTexts = [
      'Begleitperson bei Angstpatienten',
      'Übersetzer bei Verständnisproblemen',
      'Implantat-Zertifikat für metallische Fremdkörper',
      'Frühzeitige Terminverschiebeung beantragen',
      'Kinderbetreuung organisieren'
    ];

    const List<String> _checkboxTexts2 = [
      'Versicherungskarte',
      'Überweisungsschein',
      'Voraufnahmen/Op-Berichte',
      'Labor der Niere bei MRT mit Kontrastmittel',
      'Metallgegenstände vor der Untersuchung ablegen',
      'Allergiepass',
      'Implantatpass',
      'Kein Make-up bei Kopf-MRTs',
    ];

    if (context.watch<ReampStateBloc>().state is ReampStateLoaded) {
      var state = context.watch<ReampStateBloc>().state as ReampStateLoaded;

      double anxietyLevel = state.data.getOverallAnxietyLevel() / 10;
      final levelcompleted = state.data.levelscompleted;

      //anxietyLevel=1.0;
      //print(anxietyLevel);
      // anxietyLevel = 1.3;
      // Angstlevel minimal
      final bloc = context.read<ReampStateBloc>();

      if (anxietyLevel <= 1.46) {
        bloc.add(ReampStateSessionNumber(number: 1));
        vrElementeNum = 3;
        if (levelcompleted.isEmpty) {
          statusbar = 0.0;
        } else if (levelcompleted.isNotEmpty &&
            levelcompleted.containsKey("mrt_examination") == true) {
          statusbar = 1;
        }
      }

//Angstlevel middle
      if (anxietyLevel > 1.46 && anxietyLevel <= 2.93) {
        bloc.add(ReampStateSessionNumber(number: 1));
        vrElementeNum = 0;
        int numberplanElemente = 4;
        if (state.data.therapieElemente.isEmpty == false) {
          numberplanElemente = 5;
          if (state.data.therapieElemente.first ==
              "Mir helfen Atem- und Entspannungsübungen") {
            showAtem = true;
          }

          if (state.data.therapieElemente.first ==
              "Mir helfen Sachinformationen über die Situation.") {
            showLehrmaterial = true;
          }
        }

        if (levelcompleted.containsKey("Relaxation") && showAtem == false) {
          levelcompleted.remove("Relaxation");
        }

        if (levelcompleted.containsKey("Information") &&
            showLehrmaterial == false) {
          levelcompleted.remove("Information");
        }
        if (levelcompleted.isEmpty) {
          statusbar = 0.0;
        } else {
          statusbar = levelcompleted.length / numberplanElemente;
        }
        /*
      if (levelcompleted.isEmpty) {
        statusbar = 0.0;
      } else if (levelcompleted.length == 1) {
        statusbar = 1 / 5;
      } else if (levelcompleted.length == 2) {
        statusbar = 2 / 5;
      } else if (levelcompleted.length == 3) {
        statusbar = 3 / 5;
      } else if (levelcompleted.length == 4) {
        statusbar = 4 / 5;
      } else if (levelcompleted.length == 5) {
        statusbar = 1.0;
      }*/
      }
//Angstlevel high

      if (anxietyLevel > 2.93) {
        bloc.add(ReampStateSessionNumber(number: 3));

        vrElementeNum = 0;
        int numberplanElemente = 4;
        if (state.data.therapieElemente.isEmpty == false) {
          numberplanElemente = 4 + state.data.therapieElemente.length;
          if (state.data.therapieElemente
                  .contains("Mir helfen Atem- und Entspannungsübungen") ==
              true) {
            showAtem = true;
          }

          if (state.data.therapieElemente.contains(
                  "Mir helfen Sachinformationen über die Situation.") ==
              true) {
            showLehrmaterial = true;
          }
        }

        if (levelcompleted.containsKey("Relaxation") && showAtem == false) {
          levelcompleted.remove("Relaxation");
        }

        if (levelcompleted.containsKey("Information") &&
            showLehrmaterial == false) {
          levelcompleted.remove("Information");
        }

        if (levelcompleted.isEmpty) {
          statusbar = 0.0;
        } else {
          statusbar = levelcompleted.length / numberplanElemente;
        }
        /*
      if (levelcompleted.isEmpty) {
        statusbar = 0.0;
      } else if (levelcompleted.length == 1) {
        statusbar = 0.16;
      } else if (levelcompleted.length == 2) {
        statusbar = 0.33;
      } else if (levelcompleted.length == 3) {
        statusbar = 0.48;
      } else if (levelcompleted.length == 4) {
        statusbar = 0.64;
      } else if (levelcompleted.length == 5) {
        statusbar = 0.8;
      } else if (levelcompleted.length == 6) {
        statusbar = 1.0;
      }*/
      }
      //final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
      final results = state.data.checkboxesVorab;
      final results2 = state.data.checkboxesMrtTag;
      //final levelcompleted = state.data.levelscompleted;
      //print(levelcompleted);
      // print(state.data.therapieElemente);

      final resultsanxiety = state.data.assessmentResults;
      // print(resultsanxiety);
      //double anxietyLevel= state.data.getOverallAnxietyLevel();
      //print(anxietyLevel / 10);

      /* //status if anxietylevel is max
    if (levelcompleted.length == 0) {
      statusbar = 0.0;
    } else if (levelcompleted.length == 1) {
      statusbar = 0.16;
    } else if (levelcompleted.length == 2) {
      statusbar = 0.33;
    } else if (levelcompleted.length == 3) {
      statusbar = 0.48;
    } else if (levelcompleted.length == 4) {
      statusbar = 0.64;
    } else if (levelcompleted.length == 5) {
      statusbar = 0.8;
    } else if (levelcompleted.length == 6) {
      statusbar = 1.0;
    }*/

      // final bloc = context.read<LevelBloc>();
      // bloc.add(SesssionNeededChange(numberOfSessions: 1));
      //final bloc = context.read<ReampStateBloc>();
      //bloc.add(ReampStateSessionNumber(number: 1));

      if (!results.containsKey('Begleitperson bei Angstpatienten')) {
        for (int id = 0; id < _checkboxTexts.length; id++) {
          final bloc = context.read<ReampStateBloc>();
          bloc.add(
              ReampStateCheckboxAdded(id: _checkboxTexts[id], result: false));
        }
      }

      if (!results2.containsKey('Versicherungskarte')) {
        for (int id = 0; id < _checkboxTexts2.length; id++) {
          final bloc = context.read<ReampStateBloc>();
          bloc.add(
              ReampStateCheckboxAdded2(id: _checkboxTexts2[id], result: false));
        }
      }

      //print("cecklisteMRTtag");
      //print(results2);
    }
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 0.0),
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            alignment: Alignment.bottomCenter,

            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20),
                          child: Text(
                            "Willkommen",
                            style: Theme.of(context).textTheme.headline1,
                            //textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(left: 140, top: 20),
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Settings())),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Container(
                      height: 100.0,
                      width: 100.0,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        value: statusbar,
                        color: ReampColors.primaryAccent,
                        strokeWidth: 15,
                      )),
                  const SizedBox(height: 35.0),
                  Row(
                    children: [
                      SizedBox(width: 30.0),
                      Text(
                        "Deine Kurseinheiten",
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        color: Colors.grey[700],
                        iconSize: 26,
                        onPressed: () {
                          showDialog(
                              context: context, builder: _buildPanicWarning);
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 2 / 6.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: ReampColors.background,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: ReampColors.backgroundBright,
                            blurRadius: 12.0,
                            offset: const Offset(-15.0, -15.0),
                          ),
                          BoxShadow(
                            color: ReampColors.secondaryAccent,
                            blurRadius: 12.0,
                            offset: const Offset(15.0, 15.0),
                          ),
                        ],
                        // gradient: gradient,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Column(children: [
                          ExpansionTile(
                            tilePadding: EdgeInsets.only(left: 0),
                            title: Row(
                              children: [
                                Text("Virtual Reality Training",
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                //SizedBox(width: 60.0),
                                //Image.asset("assets/img/vr_3.png",height:18),//Icon(Icons.adb),
                              ],
                            ),
                            children: [
                              //here personalisieren je  nach Angstlevel wieviel von der Liste gezeigt wird final level in Levels.levels.sublist(3)
                              for (final level
                                  in Levels.levels.sublist(vrElementeNum))
                                Card(
                                  color: ReampColors.background,
                                  child: ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(level.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CoursePage(
                                                  levelConfig: level)))),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Visibility(
                            visible: showAtem,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Atem & Entspannungsübungen",
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                SizedBox(width: 3.0),
                                // Icon(Icons.air),

                                const SizedBox(width: 4.0),
                                IconButton(
                                  iconSize: 16.0,
                                  alignment: Alignment.centerRight,
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Relaxation()));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: showLehrmaterial,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Lehrmaterial",
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                SizedBox(width: 122.0),

                                /*   const Icon(
                                Icons.school
                        ),*/
                                const SizedBox(width: 6.0),
                                IconButton(
                                  iconSize: 16.0,
                                  alignment: Alignment.centerRight,
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Info()));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              //const SizedBox(height:50.0),

              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: ReampColors.background,
                fixedColor: Colors.grey[600],
                onTap: (value) {
                  if (value == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Relaxation()));
                  }
                  if (value == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => VorabPage()));
                  }
                  if (value == 2) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Info()));
                  }

                  if (value == 3) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const VRtrain()));
                  }
                },
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.air),
                    label: 'Atmen &\nEntspannung',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.assignment),
                    label: 'Checklisten\n',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'Lehrmaterial\n',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/img/vr_3.png", height: 18),
                    label: 'VR-\nTraining',
                  ),
                ],
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height / 12,
                  left: MediaQuery.of(context).size.width / 3,
                  child: Icon(
                    Icons.circle,
                    color: Colors.orange,
                    size: 15,
                  )),
              /* const Visibility(
                  visible:true,
                  child: Text("hi"),),*/
            ],
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }
/*
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
              style:  Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
    
    );

*/
}

class BackgroundColor extends CustomPainter {
  //final double offset;

  //BackgroundColor(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = ReampColors.primary;
    final rect = Rect.fromLTWH(-(size.height / 50) * (size.width / 18),
        -(size.height / 1.2), (size.height), (size.height));
    canvas.drawOval(rect, painter);
  }

  @override
  bool shouldRepaint(BackgroundColor oldDelegate) {
    return false;
  }
}
