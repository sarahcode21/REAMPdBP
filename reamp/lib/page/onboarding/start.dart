import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/checkbox1.dart';
import 'package:reamp/page/notification_api.dart';
import 'package:reamp/page/onboarding/privacy.dart';

class OnboardingStart extends StatefulWidget {
  const OnboardingStart({Key? key}) : super(key: key);

  @override
  State<OnboardingStart> createState() => _OnboardingStartState();
}

class _OnboardingStartState extends State<OnboardingStart> {
  static const List<String> _onboardingTexts = [
    "REAMP ist eine Anwendung, die dir dabei helfen soll, dich auf deine MRT-Untersuchung vorzubereiten.",
    "Dabei kombiniert REAMP verschiedene Ansätze, um dir deine Angst zu nehmen.",
    "So werden Elemente des Expositionstrainings mit Entspannungsübungen und hilfreichen Informationen über MRT-Untersuchungen kombiniert.",
    "Innerhalb der Anwendung lernst du, wie ein MRT-Gerät funktioniert und kannst den Ablauf einer Untersuchung in einer virtuellen Realität durchleben.",
  ];

  int selected = 0;
  double scrollingOffset = 0;
  final PageController controller = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    controller.addListener(
        () => setState(() => scrollingOffset = controller.page ?? 0));
    listenNotfications();
  }

  void _onClickedNotifications(String? payload) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (context) => VorabPage()),
    );
  }

  void listenNotfications() {
    NotificationAPI.onNotifications.stream.listen(_onClickedNotifications);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundColor(scrollingOffset),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "REAMP",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Herzlich willkommen!",
                style: Theme.of(context).textTheme.headline2,
              ),
              ContentBoxPageView(
                controller: controller,
                onPageChanged: (page) => setState(() => selected = page),
                height: MediaQuery.of(context).size.height / 5 * 2,
                pages: [
                  for (final text in _onboardingTexts)
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                ],
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selected + 1 == _onboardingTexts.length
                    ? PrimaryButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const OnboardingTermsAndPrivacy())),
                        child: const Text("Starten"),
                      )
                    : PrimaryButton(
                        onPressed: () => controller.animateToPage(
                          min(selected + 1, _onboardingTexts.length - 1),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                        child: const Text("Weiter"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundColor extends CustomPainter {
  final double offset;

  BackgroundColor(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = ReampColors.primary;
    final rect = Rect.fromLTWH(200 - (offset * size.width / 16),
        -(size.height / 3), (size.height / 2) * 2, (size.height / 2) * 2);
    canvas.drawOval(rect, painter);
  }

  @override
  bool shouldRepaint(BackgroundColor oldDelegate) =>
      oldDelegate.offset != offset;
}
