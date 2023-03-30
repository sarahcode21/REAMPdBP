import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/style/component/container.dart';
import 'package:reamp/core/style/layout/general.dart';
import 'package:reamp/page/home2.dart';
import 'package:reamp/page/onboarding/start.dart';

class VorabPage extends StatefulWidget {
  const VorabPage({Key? key}) : super(key: key);

  @override
  _VorabPageState createState() => _VorabPageState();
}

class _VorabPageState extends State<VorabPage> {
  static const List<String> _checkboxTexts = [
    'Begleitperson bei Angstpatienten',
    'Übersetzer bei Verständnisproblemen',
    'Implantat-Zertifikat für metallische Fremdkörper',
    'Frühzeitige Terminverschiebeung beantragen',
    'Kinderbetreuung organisieren'
  ];

  static const List<String> _checkboxTexts2 = [
    'Versicherungskarte',
    'Überweisungsschein',
    'Voraufnahmen/Op-Berichte',
    'Labor der Niere bei MRT mit Kontrastmittel',
    'Metallgegenstände vor der Untersuchung ablegen',
    'Allergiepass',
    'Implantatpass',
    'Kein Make-up bei Kopf-MRTs'
  ];

  //final cbox = Boxes.getsavedCecks();

  /* CheckboxListTile buildSingleCheckbox2(checkbox checkbox) =>CheckboxListTile(
              activeColor: Colors.orange,
              value: checkbox.ischecked,
              title: Text(
                checkbox.name,
                style:TextStyle(fontSize: 20),
                ),
              onChanged: (value) => setState(() => checkbox.ischecked=value!),
              );

  
  CheckboxListTile c1 = buildSingleCheckbox2(checkbox cbox.get('0'));
  

  final List<CheckboxListTile> allsavedboxes = [
     c1= buildSingleCheckbox(checkbox cbox.getAt(0)),
  
    ];*/

  Widget _VorabPageLayout() {
   /* if(context.watch<ReampStateBloc>().state is ReampStateLoaded){
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final results = state.data.checkboxesVorab;
    bool value = false;}*/

    //final cbox = Boxes.getsavedCecks();
    //print(cbox.get('1')!.ischecked);
   
    return GeneralLayout(
      title: "Checklisten für deinen MRT-Termin",
      showBackButton: true,
      child: SingleChildScrollView(
          child: Column(
        children: const [
          _ChecklistenTile(
            title: "Vorab Checkliste",
            checkboxenTexte: _checkboxTexts,
          ),
          _ChecklistenTile(
            title: "Checkliste MRT-Tag",
            checkboxenTexte: _checkboxTexts2,
          ),
        ],
      )),
      /* child: Column(
          children: [
          for (int group = 0; group < _checkboxTexts.length; group++ ) Column(
                children: [
                 
             
            buildSingleCheckbox( _checkboxTexts[group],results[results.keys.elementAt(group)] as bool)//results[results.keys.elementAt(group)] as bool
          ],
            ),],//Listview
        ),*/
    );
  
  }

  @override
  Widget build(BuildContext context) {
    if(context.watch<ReampStateBloc>().state is ReampStateLoaded){
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final results = state.data.checkboxesVorab;
    if (!results.containsKey('Begleitperson bei Angstpatienten')) {
      for (int id = 0; id < _checkboxTexts.length; id++) {
        final bloc = context.read<ReampStateBloc>();
        bloc.add(
            ReampStateCheckboxAdded(id: _checkboxTexts[id], result: false));
      }
    }

    /*print('checkboxes added');
    //if(cbox.get('0')==null){
    addCheckbox('Begleitperson bei Angstpatienten' ,false, '0');
    addCheckbox('Übersetzer bei Verständnisproblemen' ,false, '1');
    addCheckbox('Bei Schwangerschaft nur natives MRT' ,false, '2');
    addCheckbox('Ausgefüllten des MRT Aufklärungsbogen' ,false, '3');
    addCheckbox('Frühzeitige Terminverschiebeung beantragen' ,false, '4');
    addCheckbox('Implant-Zertifikat für metallische Fremdkörper' ,false, '5');
    addCheckbox('Kinderbetreuung organisieren' ,false, '6');
  //}*/
   
    return _VorabPageLayout(); }
    else {
       MaterialPageRoute(builder: (_) => const homescreen2());
      return OnboardingStart();
    } 
  }
/*
  Widget buildSingleCheckbox(String text, bool value) => CheckboxListTile(
      activeColor: Colors.orange,
      value: value, //cbox.get(key)!.ischecked,
      title: Text(
        text, //cbox.get(key)!.name,
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (_) {
        value = !value;
        final bloc = context.read<ReampStateBloc>();
        bloc.add(ReampStateCheckboxAdded(id: text, result: value));
      } //cbox.get(key)!.ischecked=value!),
      );*/
}

class _ChecklistenTile extends StatelessWidget {
  final String title;
  final List<String> checkboxenTexte;

  const _ChecklistenTile(
      {required this.title, required this.checkboxenTexte, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(context.watch<ReampStateBloc>().state is ReampStateLoaded){
 
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
    final results = state.data.checkboxesVorab;
    final results2 = state.data.checkboxesMrtTag;
    
    
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
            children: [
              for (int group = 0; group < checkboxenTexte.length; group++)
                Column(
                  children: [
                    if (checkboxenTexte.contains(
                      'Begleitperson bei Angstpatienten',
                    )) ...[
                      buildSingleCheckbox(
                          checkboxenTexte[group],
                          results[results.keys.elementAt(group)] as bool,
                          context),
                    ] else ...[
                      buildSingleCheckbox2(
                          checkboxenTexte[group],
                          results2[results2.keys.elementAt(group)] as bool,
                          context),
                    ]
                    //results[results.keys.elementAt(group)] as bool
                  ],
                ),
            ], //Listview
          )),
    );
    }
    return Text("Error");
  }

  Widget buildSingleCheckbox(String text, bool value, BuildContext context) =>
      CheckboxListTile(
          activeColor: Colors.orange,
          value: value, //cbox.get(key)!.ischecked,
          title: Text(
            text, //cbox.get(key)!.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onChanged: (_) {
            value = !value;
            final bloc = context.read<ReampStateBloc>();
            bloc.add(ReampStateCheckboxAdded(id: text, result: value));
          } //cbox.get(key)!.ischecked=value!),
          );

  Widget buildSingleCheckbox2(String text, bool value, BuildContext context) =>
      CheckboxListTile(
          activeColor: Colors.orange,
          value: value, //cbox.get(key)!.ischecked,
          title: Text(
            text, //cbox.get(key)!.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onChanged: (_) {
            value = !value;
            final bloc = context.read<ReampStateBloc>();
            bloc.add(ReampStateCheckboxAdded2(id: text, result: value));
          } //cbox.get(key)!.ischecked=value!),
          );
}
  /*Future <void> addCheckbox(String name ,bool value,String id)async {
    final newcheckbox= checkbox()
    ..name = name
    ..ischecked = value;

    final box = Boxes.getsavedCecks();
    //box.add(newcheckbox);
    box.put(id,newcheckbox);

  }*/