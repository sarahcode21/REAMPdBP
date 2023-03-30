import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:reamp/core/style/style.dart';

const termsData = """
# Nutzungsbedingungen
## Präambel

Die CodeCamp:N GmbH ist ein Dienstleister für Produkte und Dienstleistungen, vorrangig im
digitalen Bereich, insbesondere für Unternehmen der Finanzdienstleistungsbranche sowie für
Verbraucher, welche Services in Form von Apps im Apple Store iOS (progressive Web-Apps) zur
Verfügung stellt.

Das Ziel der Anwendnung ist es bei Nutzer\\*innen, mittels Virtual Reality, ein hohes Stresslevel und
Angst vor MRT-Untersuchungen zu reduzieren. Die Anwendung lässt sich auf gängigen Smartphones
in Verbindung mit einer Virtual-Reality-Brille verwenden und bietet Nutzer\\*innen die Möglichkeit
sich auf einen MRT-Termin eigenständig vorzubereiten.

Nicht anfallsfreie und therapieresistente Epilepsie-Probanden, oder solche, die empfindlich 
gegen Lichtblitze oder Muster sind, anderweitige gesundheitliche Bedenken bei der Benutzung einer 
VR-Brille haben, Alkohol oder Drogen zu sich genommen haben, schwanger sind oder Vorerkrankungen 
haben, ist die Nutzung einer VR-Brille untersagt.

## 1. Allgemeines und Geltungsbereich

1.1. Die CodeCamp:N GmbH erbringt gegenüber den Nutzer\\*innen der REAMP Anwendung
Leistungen nach Maßgabe dieser Nutzungsbedingungen.

1.2. Diese Nutzungsbedingungen gelten zwischen der CodeCamp:N GmbH und denNutzer\\*innen der
App REAMP.

1.3. Die Nutzungsbedingungen gelten ausschließlich. Etwaige entgegenstehende oder von diesen
abweichenden Nutzungsbedingungen der Nutzer\\*innen sind nur wirksam, soweit sie mit den
vorliegenden Nutzungsbedingungen inhaltlich übereinstimmen oder von der CodeCamp:N GmbH
ausdrücklich schriftlich anerkannt wurden. Dies gilt auch, wenn die CodeCamp:N GmbH in Kenntnis
entgegenstehender oder abweichender Bedingungen der Nutzer\\*innen Leistungen vorbehaltlos
erbringt.

1.4. Für die Umsetzung unseres Ziels stellt die CodeCamp:N GmbH eine kostenlose
Expositionstherapie via Virtual Reality zur Verfügung. Dadurch können sich Nutzer\\*innen besser auf
MRT Untersuchungen vorbereiten und so ihre Angst verringern und damit gleichzeitig Verzögerungen
im Untersuchungsablauf, Untersuchungsabbrüche und Nichterscheinen reduzieren.

Die Anwendung lässt sich auf gängigen Smartphones in Verbindung mit einer Virtual-Reality-Brille
verwenden und bietet Nutzer\\*innen die Möglichkeit sich auf den MRT-Termin eigenständig
vorzubereiten. Das leicht zugängliche Training in Kombination mit zusätzlichen Informationen kann
außerdem dabei helfen, weniger Beruhigungsmittel einzusetzen und den damit verbundenen
Aufklärungsbedarf zu verringern.

Die Erhebung, Verarbeitung und Nutzung deiner Daten durch die CodeCamp:N GmbH im
Zusammenhang mit der REAMP Anwendung erfolgt ausschließlich für ebendiesen Zweck und allen
damit verbundenen Aufgaben. Hierzu erheben, verarbeiten und nutzen wir Daten, die du uns im
Rahmen der Nutzung der REAMP ANWENDUNG mitteilst, sowie gegebenenfalls Daten, die wir für die
ordnungsgemäße Durchführung von dir im weiteren Verlauf abfragen.

1.5. Die Codecamp:N GmbH übernimmt ausdrücklich keine Gewähr füreinen Therapie- oder
Behandlungserfolg.

## 2. Zugang und Verfügbarkeit

2.1. Wir, die CodeCamp:N GmbH garantieren nicht, dass alle Smartphones und Betriebssysteme die
REAMP Anwendung unterstützen.

2.2. Wir, die CodeCamp:N GmbH GmbH, behalten uns das Recht vor, die REAMP Anwendung
jederzeit zu aktualisieren, erweitern, überarbeiten oder einzustellen um auf veränderte
Nutzerinteressen oder auf neue technische Begebenheiten oder Forschungsergebnisse zu reagieren.
Dafür empfehlen wir denNutzer\\*innen im eigenen Interesse die Anwendung und alle weiteren
systemrelevanten Komponenten des jeweiligen Endgeräts auf dem aktuellsten Stand zu halten.

2.3. Grundsätzlich versuchen wir die REAMP Anwendung uneingeschränkt zur Verfügung zu stellen.
Allerdings übernehmen wir keine Haftung für die ständige Verfügbarkeit der Anwendung.

2.4. Die CodeCamp:N GmbH kann die Verfügbarkeit zeitweilig beschränken sowie zu jeder Zeit
einstellen.

## 3. Protokolldaten

Mit deiner Anmeldung bei der App werden Grunddaten (Datum und Uhrzeit der Anmeldung) an uns
übermittelt. Dies geschieht durch “Firebase Analytics” und „Facebook Pixel“. Diese Daten werden
ausschließlich für die Nutzung der App und deren Leistungen erhoben, gespeichert und verwendet.
Es ist uns nicht möglich, die so erfassten Daten einer bestimmten natürlichen Person zuzuordnen.
Sämtliche dieser Daten werden von uns ausschließlich zu statistischen Zwecken ausgewertet. Eine
Weitergabe dieser Daten an Dritte oder eine Verknüpfung mit anderen Daten erfolgt nicht.

## 4. Bereitstellung der REAMP Anwendung

Die Nutzung der REAMP Anwendung ist nur möglich, wenn du vor Nutzung der Anwendung
ausdrücklich den Nutzungsbedingungen zustimmst.

## 5. Potenziale

Nutzer\\*innen der Anwendung können sich durch das leicht zugängliche Training in Kombination mit
zusätzlichen Informationen auf eine bevorstehende MRT-Termin eigenständig vorbereiten.

## 6. Nutzung und Bedingungen

6.1. Vor der Nutzung der Anwendung müssen sich Nutzer\\*innen zuerst persönlich bei uns
registrieren und ein Nutzungsprofil anlegen. Dazu sind E-Mail-Adresse und ein den festgelegten
Sicherheitskriterien entsprechendes Passwort erforderlich. Die Nutzer\\*innen erhalten dann eine
EMail an die angegebene E-Mail-Adresse, die dann innerhalb von 2 Wochen bestätigt werden muss.
Erfolgt keine Bestätigung, wird das Nutzungskonto innerhalb von 2 Wochen gelöscht. Es gelten die
etwaigen Bestimmungen des Anbieters.

6.2. Die Nutzer\\*innen dürfen nur eine existierende E-Mail Adresse, zu derenNutzung sie berechtigt
sind für die Dienste der App verwenden.

6.3. Die Nutzer\\*innen dürfen die Anwendung ausschließlich privat nutzen.

6.4. Die Nutzer\\*innen dürfen keine Schadsoftware in die Anwendung einschleusen oder dies
versuchen.

6.5. Die Nutzer\\*innen dürfen ihre Endgeräte nicht entgegen der Geschäftsbedingungen des
Geräteherstellers modifizieren oder Nutzungsbeschränkungen von Funktionen die der
Gerätehersteller serienmäßig gesperrt hat unbefugt, umgehen.

6.6. Die Nutzer\\*innen dürfen den Quellcode der App nicht auslesen, verändern oder in sonstiger Art
und Weiße verwerten. Auch der Versuch ist untersagt. Die App darf nicht für Zwecke benutzt werden
die dem geltenden Recht widersprechen.

6.7. Verstoßen die Nutzer\\*innen gegen die Nutzungsbedingungen, ist die CodeCamp:N GmbH
berechtigt, den gewünschten Service nicht durchzuführen und das Nutzungskonto zu sperren.

6.8. Das für die REAMP Anwendung erforderliche Smartphone und Virtual-Reality-Brille werden nicht
durch die CodeCamp:N zur Verfügung gestellt.

## 7. Vergütung
Die REAMP Anwendung wird denNutzer\\*innen von der CodeCamp:N kostenfrei zur Verfügung
gestellt. Für die Nutzung der REAMP Anwendung wird eine Internetverbindung benötigt, hierbei
können jedoch Verbindungs- und Übertragungsentgelte anfallen, die durch den jeweiligen
Internetprovider derNutzer\\*innen erhoben werden und von denNutzer\\*innen selbst zu tragen sind.

## 8. Leistungen externer Dienstleister

8.1. Die CodeCamp:N GmbH ist berechtigt, die Ausführung gegenwärtiger und künftiger Leistungen
der App von verbundenen Unternehmen oder unabhängigen Dienstleistern ausführen zu lassen.

8.2. Handelt es sich bei den in der App angezeigten Informationen um Informationen und Leistungen
von unabhängigen Dienstleistern, sind die Leistung der CodeCamp:N GmbH darauf beschränkt diese
Informationen zu vermitteln und die technischen und organisatorischen Abläufe der App
bereitzustellen. Die CodeCamp:N GmbH hat keinerlei Einfluss auf die übermittelten Inhalte und
haftet nicht für Schäden, die aufgrund unrichtiger oder unvollständiger Informationen entstehen. Die
Nutzer\\*innen erkennen an, dass sie keine Erfüllungsgehilfe der CodeCamp:N GmbH sind.

## 9. Datenschutz

Die CodeCamp:N GmbH erhebt, verarbeitet und nutzt personenbezogene Daten ausschließlich zu
dem Zweck der Erbringung der REAMP Anwendung. Eine darüber hinausgehende Verwendung der
Daten durch die CodeCamp:N GmbH erfolgt nicht.

Siehe auch die gesonderten Datenschutzhinweise, die in der Anwendung unter Einstellungen sowie
bei der Registrierung hinterlegt sind und auf unserer Website: www.codecamp-n.com jederzeit
abgerufen werden können.

## 10. Mängel der Anwendung

Die Nutzer\\*innen haben keinen Anspruch auf Aufrechterhaltung oder Herbeiführung eines
bestimmten Zustandes und/oder Funktionsumfangs der Anwendung. Garantien im Rechtssinn
werden nicht übernommen.

## 11. Haftung

11.1. Die CodeCamp:N GmbH haftet auf Schadensersatz nach den gesetzlichen Bestimmungen für
Personenschäden und für Schäden nach dem Produkthaftungsgesetz.

11.2. Für sonstige Schäden haftet die CodeCamp:N GmbH, sofern sich nicht aus einer von der
CodeCamp:N GmbH übernommenen Garantie etwas anderes ergibt, nach Maßgabe der folgenden
Bestimmungen.

11.3. Die CodeCamp:N GmbH haftet nach den gesetzlichen Bestimmungen für Schäden, die durch
arglistiges Verhalten verursacht wurden, sowie für Schäden, die durch Vorsatz oder grobe
Fahrlässigkeit von der CodeCamp:N GmbH, den gesetzlichen Vertreter oder den leitenden
Angestellten der CodeCamp:N GmbH verursacht wurden.

11.4. Die CodeCamp:N GmbH haftet auf Schadensersatz begrenzt auf die Höhe des vertragstypischen
vorhersehbaren Schadens − für Schäden aus einer leicht fahrlässigen Verletzung wesentlicher
Vertragspflichten oder von Pflichten, deren Erfüllung die ordnungsgemäße Durchführung des
Vertrages überhaupt erst ermöglicht und auf deren Einhaltung du regelmäßig vertrauen darfst
(Kardinalpflichten) − sowie für Schäden, die von einfachen Erfüllungsgehilfen von der CodeCamp:N
GmbH vorsätzlich oder grob fahrlässig verursacht wurden. − Im Übrigen ist jegliche Haftung von der
CodeCamp:N GmbH für fahrlässig verursachte Schäden ausgeschlossen.

11.5. Der Nutzer ist verpflichtet, etwaige Schäden im Sinne vorstehender Haftungsregelungen
unverzüglich gegenüber der CodeCamp:N GmbH schriftlich anzuzeigen oder von der CodeCamp:N
GmbH aufnehmen zu lassen, so dass die CodeCamp:N GmbH möglichst frühzeitig informiert ist und
eventuell gemeinsam mit dem Nutzer noch Schadensminderung betreiben kann.

## 12. Haftungsausschluss

12.1. Die CodeCamp:N übernimmt keinerlei Gewähr für die Aktualität, Richtigkeit und Vollständigkeit
der bereitgestellten Informationen in der REAMP Anwendung als auch auf der REAMP Website.
Haftungsansprüche gegen die CodeCamp:N, welche sich auf Schäden materieller oder ideeller Art
beziehen, die durch die Nutzung oder Nichtnutzung der dargestellten Informationen bzw. durch die
Nutzung fehlerhafter und unvollständiger Informationen verursacht wurden, sind grundsätzlich
ausgeschlossen, sofern seitens der CodeCamp:N kein nachweislich vorsätzliches oder grob
fahrlässiges Verschulden vorliegt.

12.2. Die in der REAMP Anwendung dargestellten Informationen stellen keine Aufklärung im Sinne
einer ärztlichen Aufklärungspflicht dar und ersetzen diese auch nicht. Die CodeCamp:N übernimmt
keine Gewährfür die Wirksamkeit der Expositionstherapie und weist ausdrücklich darauf hin, dass
das Training Nutzer\\*innen lediglich die Möglichkeit gibt, sich besser auf einen MRT-Termin
vorzubereiten. Die Verantwortung für Durchführung eines MRT-Termins obliegt dem Nutzer allein.

12.3. Die CodeCamp:N übernimmt keine Haftung für Schäden die mit der Nutzung von VirtualReality-Brillen entstehen.

## 13. Sonstiges

13.1. Diese Nutzungsbedingungen und alle unter Einbeziehung dieser Nutzungsbedingungen
zwischen der CodeCamp:N GmbH und denNutzer\\*innen unterliegen dem Recht der Bundesrepublik
Deutschland unter Ausschluss des Kollisionsrechts und des Übereinkommens de r Vereinten Nationen
vom 11. April 1980 über Verträge über den internationalen Warenkauf (UN-Kaufrecht).

13.2. Die CodeCamp:N GmbH kann diese Nutzungsbedingungen jederzeit mit Wirkung für die Zukunft
ändern. Eine solche Änderung teilen wir über die App mit. Änderungen und Ergänzungen dieser
Nutzungsbedingungen bedürfen der Textform. Dies gilt auch für eine Änderung oder Aufhebung
dieses Textformerfordernisses. Die Nutzer\\*innen können den Änderungen innerhalb von 6 Wochen 
nach der Mitteilung über die Änderung widersprechen. Nach erfolgtem Widerspruch behalten wir
uns das Recht vor, die Anwendung gegenüber denNutzer\\*innen einzustellen.

13.3. Sollten einzelne Bestimmungen dieser Nutzungsbedingungen unwirksam oder nicht
durchsetzbar sein oder werden oder eine Lücke enthalten, so bleiben die übrigen Bestimmungen
hiervon unberührt. Die Parteien verpflichten sich, anstelle der unwirksamen oder nicht
durchsetzbaren Regelung eine wirksame und durchsetzbare Regelung zu treffen, die dem
wirtschaftlichen Zweck der unwirksamen oder nicht durchsetzbaren Regelung am nächsten kommt
bzw. diese Lücke ausfüllt.

_Aktueller Stand: 16.09.2021_
""";

class ReampTermsAndConditions extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  ReampTermsAndConditions({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      title: "Datenschutz und Nutzungsbedingungen",
      showBackButton: true,
      scrollController: _controller,
      fab: FloatingActionButton(
        onPressed: () => _controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease),
        child: const Icon(Icons.keyboard_arrow_up),
      ),
      child: Column(
        children: const [
          MarkdownBody(
            data: termsData,
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
