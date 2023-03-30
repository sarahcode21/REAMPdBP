import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/home2.dart';

class OnboardingTherapyPlan extends StatefulWidget {
  const OnboardingTherapyPlan({Key? key}) : super(key: key);

  @override
  State<OnboardingTherapyPlan> createState() => _OnboardingTherapyPlanState();
}

class _OnboardingTherapyPlanState extends State<OnboardingTherapyPlan> {
  static List<String> texts = [];
  static List<String> texts1 = [
    "Dein Virtual Reality Training ist in 4 Level aufgebaut. In jedem Level erlebst du Teile einer MRT-Untersuchung in virtueller Realität (VR).",
    "Level 1: Du startest im Wartezimmer und kannst dich erstmal an die virtuelle Realität gewöhnen.\nLevel 2: Du kannst einen ersten Blick auf das MRT-Gerät werfen\nLevel 3: Du kannst das MRT-Gerät genauer betrachten\nLevel 4: Du erlebst eine komplette MRT-Untersuchung",
    "Um gut auf deine MRT-Untersuchung vorbereitet zu sein, solltest du jedes Level dreimal durchlaufen.",
    "Zusätzlich kannst du dir erklären lassen, wie ein MRT-Gerät funktioniert und verschiedene Entspannungsübungen ausprobieren.",
    "Außerdem kannst du dir weitere Elemente zur Vorbereitung auf dein MRT anschauen. Diese findest du in der Navigationsleiste auf deinem personalisierten Homebildschirm."
  ];

  static List<String> texts2 = [
    "Dein Virtual Reality Training ist in 4 Level aufgebaut. In jedem Level erlebst du Teile einer MRT-Untersuchung in virtueller Realität (VR).",
    "Level 1: Du startest im Wartezimmer und kannst dich erstmal an die virtuelle Realität gewöhnen.\nLevel 2: Du kannst einen ersten Blick auf das MRT-Gerät werfen\nLevel 3: Du kannst das MRT-Gerät genauer betrachten\nLevel 4: Du erlebst eine komplette MRT-Untersuchung",
    "Um gut auf deine MRT-Untersuchung vorbereitet zu sein, solltest du jedes Level einmal durchlaufen.",
    "Zusätzlich kannst du dir erklären lassen, wie ein MRT-Gerät funktioniert oder verschiedene Entspannungsübungen ausprobieren.",
    "Außerdem kannst du dir weitere Elemente zur Vorbereitung auf dein MRT anschauen. Diese findest du in der Navigationsleiste auf deinem personalisierten Homebildschirm."
  ];

  static List<String> texts3 = [
    "In deinem Virtual Reality Training kannst du eine MRT-Untersuchung erleben.",
    "Außerdem kannst du dir weitere Elemente zur Vorbereitung auf dein MRT anschauen. Diese findest du in der Navigationsleiste auf deinem personalisierten Homebildschirm."
  ];

  String fullTraining =
      "REAMP ist in 4 Level aufgebaut. In jedem Level erlebst du Teile einer MRT-Untersuchung in virtueller Realität (VR). \nLevel 1: Du startest im Wartezimmer und kannst dich erstmal an die virtuelle Realität gewöhnen.\n\nLevel 2: Du kannst einen ersten Blick auf das MRT-Gerät werfen\nLevel 3: Du kannst das MRT-Gerät genauer betrachten\nLevel 4: Du erlebst eine komplette MRT-Untersuchung";

  bool enabled = texts.length == 1;
  bool dataload = false;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
// Save data of assessment in database
    if (dataload == false) {
      final databaseReference = FirebaseDatabase.instance.ref();
      final datajson = state.data.toJson().toString();
      databaseReference.child('Probanden2').set({
        'Proband1': datajson,
        'timestamp': DateTime.now().toString(),
      });
      dataload = true;
    }
    double anxietyLevel = state.data.getOverallAnxietyLevel();
    anxietyLevel = anxietyLevel / 10;
    if (anxietyLevel <= 1.46) {
      texts = texts3;
    }
    if (anxietyLevel > 1.46 && anxietyLevel <= 2.93) {
      texts = texts2;
    }
    if (anxietyLevel > 2.93) {
      texts = texts1;
    }
    //texts.add(fullTraining);
    return OnboardingLayout(
      title: "Dein Therapieplan",
      onPressed: enabled
          ? () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const homescreen2()),
              (route) => false)
          : null,
      showBox: false,
      padding: false,
      child: ContentBoxPageView(
        height: MediaQuery.of(context).size.height * 2 / 4.5,
        onPageChanged: (page) =>
            setState(() => enabled = (page + 1) == texts.length),
        pages: [for (final text in texts) Text(text)],
      ),
    );
  }
}
