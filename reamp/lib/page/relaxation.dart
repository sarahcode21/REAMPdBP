import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/style/style.dart';

class Relaxation extends StatelessWidget {
  Map<String, bool> expanded = {};
  Relaxation({Key? key}) : super(key: key);

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
      title: "Tipps zum Entspannen",
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
                bloc.add(ReampStateLevelCompletedAdded(
                    id: "Relaxation", result: true));
                showCompletedDialog(context);
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
          ContentBox(
            child: Column(
              children: [
                Text(
                  "Zur Reduktion von Stress, der in Zusammenhang mit Angst entsteht, können verschiedene Übungen angewandt werden.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          _MarkdownInfoTile(
            title: "Bauchatmung",
            content: """
Eine einfache aber wirksame Methode ist die Bauch- / Zwerchfellatmung: 
Hierzu atmet man langsam tief ein, sodass sich der Bauch nach außen wölbt. 
Hierdurch wird eine gute Sauerstoff-Aufnahme in der Lunge erreicht. Beim Ausatmen 
lässt man die Anspannung des Zwerchfells einfach los, sodass die Luft wie von 
selbst aus der Lunge wieder herausströmt. Wiederhole diesen Vorgang insgesamt 10 Mal.
""",
            expanded: expanded,
          ),
          _MarkdownInfoTile(
            title: "4711",
            content: """
Bei der 4711-Technik atmet man für 4 Sekunden ein und für 7 Sekunden aus. 
Wiederhole diesen Vorgang insgesamt 11 Mal.
""",
            expanded: expanded,
          ),
          _MarkdownInfoTile(
            title: "Box-Atmung",
            content: """
Bei der Box-Atmung wird für jeweils 4 Sekunden eingeatmet, die Luft angehalten, 
ausgeatmet und erneuet die Luft angehalten. Wiederhole diesen Vorgang insgesamt 10 Mal.
""",
            expanded: expanded,
          ),
        ],
      ),
    );
  }
}

class _MarkdownInfoTile extends StatelessWidget {
  final String title;
  final String content;
  Map<String, bool> expanded;

  _MarkdownInfoTile(
      {required this.title,
      required this.content,
      required this.expanded,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText1;
    return ContentBox(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.air),
          ),
          collapsedIconColor: textTheme?.color,
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
            MarkdownBody(
              data: content,
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
    print(expanded);
  }
}

class ConfettiDialog extends StatefulWidget {
  final Widget child;

  const ConfettiDialog({required this.child, Key? key}) : super(key: key);

  @override
  _ConfettiDialogState createState() => _ConfettiDialogState();
}

class _ConfettiDialogState extends State<ConfettiDialog> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Center(
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirection: 0,
            numberOfParticles: 30,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
