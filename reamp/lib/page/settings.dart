import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:reamp/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/main.dart';
import 'package:reamp/page/onboarding/start.dart';
import 'package:reamp/page/terms.dart';
import 'package:uuid/uuid.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _uploadWaitDialog(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Hochladen…"),
            SizedBox(height: 32),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _showUploadDialogResult(
      {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void uploadJSON(String data) async {
    showDialog(context: context, builder: _uploadWaitDialog);

    try {
      final publicPem = await rootBundle.loadString('crypt/public.pem');
      final publicKey = encrypt.RSAKeyParser().parse(publicPem) as RSAPublicKey;
      final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));

      data = encrypter.encrypt(data).base64;

      // Create a Reference to the file
      var storageInstance = firebase_storage.FirebaseStorage.instance;
      storageInstance.setMaxUploadRetryTime(const Duration(seconds: 3));
      storageInstance.setMaxOperationRetryTime(const Duration(seconds: 3));
      firebase_storage.Reference ref = storageInstance
          .ref()
          .child('exported')
          .child('/${const Uuid().v4().toString()}.json.rsa');

      // Start upload of putString
      await ref.putString(data);

      Navigator.pop(context);
      _showUploadDialogResult(
        title: "Upload Erfolgreich!",
        content: "Die App kann jetzt zurückgesetzt werden.",
      );
    } catch (e) {
      Navigator.pop(context);
      _showUploadDialogResult(
        title: "Upload fehlgeschlagen!",
        content:
            "Bitte die Internetverbindung überprüfen! Die App kann noch nicht zurückgesetzt werden.",
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ReampStateBloc>();
    return GeneralLayout(
      title: "Einstellungen",
      showBackButton: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SecondaryButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ReampTermsAndConditions())),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Text(
              "Datenschutz und Nutzungsbedingungen",
              textAlign: TextAlign.center,
            ),
          ),
          SecondaryButton(
            onPressed: () => showLicensePage(context: context),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Text("Open Source Lizenzen"),
          ),
          PrimaryButton(
            onPressed: () => PasswordUnlock.showPasswordUnlock(
              context: context,
              password: "PleaseResetReamp",
              callback: () async {
                uploadJSON((bloc.state as ReampStateLoaded)
                    .data
                    .getAnonymousJson()
                    .toString());
              },
            ),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Text(
              "Nutzerdaten anonymisieren und exportieren",
              textAlign: TextAlign.center,
            ),
          ),
          PrimaryButton(
            onPressed: () => PasswordUnlock.showPasswordUnlock(
              context: context,
              password: "PleaseResetReamp",
              callback: () async {
                bloc.add(ReampStateReset());
                
                
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const OnboardingStart()),
                    (Route<dynamic> route)=> false);
                   
              },
            ),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Text("App zurücksetzen"),
          ),
          PrimaryButton(
            onPressed: () => PasswordUnlock.showPasswordUnlock(
                callback: () async {
                  bloc.add(ReampStatePresentationMode());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OnboardingStart()),
                      (route) => false);
                },
                context: context,
                password: "PresentationMode"),
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Text("Präsentationsmodus"),
          ),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
              final data = snapshot.data;
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done &&
                  data != null) {
                final PackageInfo info = data;
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                      "${info.appName} ${info.version}+${info.buildNumber}"),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

class PasswordUnlock extends StatefulWidget {
  final String password;

  const PasswordUnlock({Key? key, required this.password}) : super(key: key);

  static Future<bool> showPasswordUnlock(
      {required AsyncCallback callback,
      required BuildContext context,
      required String password}) async {
    final bool unlocked = (await showDialog<bool?>(
          context: context,
          builder: (context) => PasswordUnlock(password: password),
        )) ??
        false;
    if (unlocked) {
      await callback();
    }
    return unlocked;
  }

  @override
  _PasswordUnlockState createState() => _PasswordUnlockState();
}

class _PasswordUnlockState extends State<PasswordUnlock> {
  final controller = TextEditingController();
  String? error;
  bool visible = false;

  void check() {
    if (controller.text == widget.password) {
      Navigator.pop(context, true);
    } else {
      setState(() => error = "Falsches Passwort!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Passwort eingeben"),
      content: TextField(
        controller: controller,
        onSubmitted: (_) => check(),
        obscureText: !visible,
        decoration: InputDecoration(
          errorText: error,
          suffixIcon: IconButton(
            icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => visible = !visible),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Abbrechen'),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: const Text('Weiter'),
          onPressed: () => check(),
        ),
      ],
    );
  }
}
