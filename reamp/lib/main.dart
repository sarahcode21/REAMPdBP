import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/page/home2.dart';
import 'package:reamp/page/notification_api.dart';
import 'package:reamp/page/onboarding/start.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  tz.initializeTimeZones();
  runApp(const MyApp());
  NotificationAPI.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (_) => ReampStateBloc()..add(ReampStateInit()),
        child: MaterialApp(
          title: 'REAMP',
          theme: ReampTheme.reampTheme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('de'),
          ],
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<ReampStateBloc, ReampStateState>(
            builder: (BuildContext context, ReampStateState state) {
              if (state is ReampStateOnboarding) {
                return const OnboardingStart();
              } else if (state is ReampStateLoaded) {
                if (state.data.onboardingFinished == true) {
                  // hier wenn variable gesetzt
                  //test
                  return const homescreen2();
                } else {
                  return const OnboardingStart();
                }
              } else {
                return const Scaffold();
              }
            },
          ),
        ),
      ),
    );
  }
}
