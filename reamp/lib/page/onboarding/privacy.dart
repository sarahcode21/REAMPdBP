import 'package:flutter/material.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment.dart';
import 'package:reamp/page/onboarding/hinweis.dart';
import 'package:reamp/page/onboarding/mrtDate.dart';
import 'package:reamp/page/onboarding/selbsteinschaetzungInfo.dart';
import 'package:reamp/page/terms.dart';

class OnboardingTermsAndPrivacy extends StatefulWidget {
  const OnboardingTermsAndPrivacy({Key? key}) : super(key: key);

  @override
  _OnboardingTermsAndPrivacyState createState() =>
      _OnboardingTermsAndPrivacyState();
}

class _OnboardingTermsAndPrivacyState extends State<OnboardingTermsAndPrivacy> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      title: "Datenschutz und Nutzungsbedingungen",
      onPressed: accepted
          ? () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const MrtTag()))
          : null,
      child: Column(
        children: [
          SecondaryButton(
            child: const Text("Öffnen"),
            margin: EdgeInsets.zero,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ReampTermsAndConditions())),
          ),
          const SizedBox(height: 32.0),
          MaterialButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => setState(() => accepted = !accepted),
            child: Row(
              children: [
                Checkbox(
                  value: accepted,
                  onChanged: (change) => setState(() => accepted = change!),
                ),
                Expanded(
                  child: Text(
                    "Ich habe die Nutzungsbedingungen sowie die Datenschutzbedingungen gelesen und erkläre mich mit diesen einverstanden.",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
