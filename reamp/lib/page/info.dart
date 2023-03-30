import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/level.dart';

class Info extends StatelessWidget {
  Map<String, bool> expanded = {};
  Info({Key? key}) : super(key: key);

  void showCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfettiDialog(
        child: AlertDialog(
          title: const Text("Herzlichen Glückwunsch!"),
          content: const Text("Du hast die Kurseinheit erfolgreich beendet!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Weiter"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReampStateBloc>();
    return GeneralLayout(
      title: "Lehrmaterial zum MRT",
      showBackButton: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(0.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
              if (expanded.length >= 3) {
                showCompletedDialog(context);
                bloc.add(ReampStateLevelCompletedAdded(
                    id: "Information", result: true));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios, size: 18),
                Text(
                  "Zurück",
                  style: Theme.of(context).textTheme.button,
                ),
              ],
            ),
          ),
          _InfoTile(
            title: "Wie funktioniert ein MRT?",
            content:
                "Während der MRT-Untersuchung werden Sie im für den Menschen völlig ungefährlichen Magnetfeld des MRT-Gerätes untersucht. Durch das starke Magnetfeld passt sich die Ausrichtung der Wasserstoffkerne im Körper parallel zum Magnetfeld an. Mit einem zusätzlichen Radiowellen-Impuls kann nur diese Ausrichtung kurzfristig verändert werden, während der Rückkehr in die parallele Ausrichtung zum Magnetfeld können feinste Signale von den sogenannten Spulen im MRT-Gerät empfangen werden, woraus die MRT-Bilder erzeugt werden können. Das MRT-Gerät arbeitet nicht mit Röntgenstrahlen, sodass für den Körper keine potentiell schädliche Strahlenbelastung entsteht und die MRT-Untersuchung auch mehrfach wiederholt werden kann.",
            expanded: expanded,
          ),
          _InfoTile(
            title: "Woher kommen die Geräusche im MRT?",
            content:
                "Laute klopfende oder hämmernde Geräusche während der Untersuchung mittels MRT sind völlig normal. Die Geräusche kommen vom Umschalten der Magneten im MRT Gerät. Die Geräusche sind etwa so laut wie eine Bohrmaschine, weshalb alle Patienten:innen einen Lärmschutz in Form von Kopfhörern während der Untersuchung erhalten.",
            expanded: expanded,
          ),
          _InfoTile(
            title:
                "Wieso verändern sich die Geräusche während der Untersuchung?",
            content:
                "Für die Beurteilung der Bilder werden unterschiedliche Bildkontraste während der Untersuchung aufgenommen, die zum Beispiel eher das Fettgewebe oder Wasseranteile im Gewebe darstellen. Für jeden Bildkontrast erfolgt eine eigene Aufnahme im MRT Gerät, mit unterschiedlichen Geräuschen. Die Geräusche werden sich dabei während der Untersuchung in Lautstärke, Tonhöhe und Frequenz verändern, dies ist völlig normal.",
            expanded: expanded,
          ),
          _InfoTile(
            title: "Spüre ich etwas während der MRT-Untersuchung?",
            content:
                "Die Bildaufnahme während der MRT-Untersuchung spüren Sie in der Regel nicht. Gelegentlich kann es zu harmlosen Muskelzuckungen während der Untersuchungen kommen oder zu einem Wärmegefühl. Auch der Tisch kann sich während der Untersuchung bewegen, dies ist ebenfalls normal.",
            expanded: expanded,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String content;
  Map<String, bool> expanded;

  _InfoTile(
      {required this.title,
      required this.content,
      required this.expanded,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText1;
    return ContentBox(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          textColor: textTheme?.color,
          iconColor: textTheme?.color,
          tilePadding: EdgeInsets.zero,
          title: Text(
            title,
            style: textTheme,
          ),
          onExpansionChanged: (bool expanding) =>
              _onExpansion(expanding, expanded, title),
          children: [
            Text(
              content,
              style: textTheme,
            ),
          ],
        ),
      ),
    );
  }

  _onExpansion(bool expanding, Map<String, bool> expanded, String title) {
    if (expanding == true) {
      expanded[title] = true;
    }
  }
}
