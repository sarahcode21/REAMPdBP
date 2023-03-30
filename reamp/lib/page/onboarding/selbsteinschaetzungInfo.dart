import 'package:flutter/material.dart';
import 'package:reamp/core/style/layout/general.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment.dart';

class SelbstInfo extends StatelessWidget {
  const SelbstInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      showBackButton: true,
      title: "Selbsteinschätzung",
      child: Column(children: [
        //const SizedBox(height:30),

        ContentBox(
            child: Text(
          "Damit REAMP dir helfen kann deine Angst zu überwinden, wollen wir dir einen persönlichen Therapieplan erstellen. Dafür werden dir Fragen zu den Themen MRT und Angst gestellt. Bitte nimm dir ca 10 min Zeit, um die Selbsteinschätzung abzuschließen. Nach der Selbsteinschätzung erstellt dir REAMP deinen persönlichen Therapieplan.",
          style: Theme.of(context).textTheme.bodyText1,
        )),
        //const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PrimaryButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const OnboardingAssessment())),
            child: const Text("Selbsteinschätzung starten"),
          ),
        ),
      ]),
    );
  }
}
