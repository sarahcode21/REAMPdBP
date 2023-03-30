import 'package:flutter/material.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/extensions.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/notification_api.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/hinweis.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/selbsteinschaetzungInfo.dart';
import 'package:timezone/timezone.dart' as tz;

class MrtTag extends StatefulWidget {
  const MrtTag({Key? key}) : super(key: key);

  @override
  _MrtTagState createState() => _MrtTagState();
}

class _MrtTagState extends State<MrtTag> {
  DateTime selectedDate = DateTime.now();
  bool clicked = false;

  /*final bloc = context.read<ReampStateBloc>();
  final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
  final  results = state.data.checkboxesVorab;*/
  Widget _buildWarningDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Achtung"),
      content:
          const Text("Bitte wähle ein Datum aus, das in der Zukunft liegt"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Verstanden"),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    /*final state = context.watch<ReampStateBloc>().state;
    if(state.toString() == "ReampStateLoaded"){ 
       final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
      final  box = state.data.mrtDate;
      selectedDate= box!;
      print(selectedDate);

    }
    else{selectedDate = DateTime.now();
    
    }*/

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    final bloc = context.read<ReampStateBloc>();
    if (picked != null /*&& picked != selectedDate*/) {
      print('make notification');
      NotificationAPI.showScheduledNotification(
        title: 'MRT Termin',
        body: 'Morgen ist dein MRT-Termin, hier ist eine Checkliste für morgen',
        scheduledDate: DateTime.now().add(const Duration(seconds: 2)),
      );
      setState(() {
        print('set State');
        selectedDate = picked;
        clicked = true;
        bloc.add(ReampStateDateTime(mrtDate: selectedDate));

        // before delete old entries
      });
    }
  }

  void submit() async {
    if (selectedDate.isBefore(DateTime.now()) ||
        selectedDate == DateTime.now()) {
      await showDialog(context: context, builder: _buildWarningDialog);
    } else {
      NotificationAPI.showScheduledNotification(
          title: 'MRT Termin',
          body: 'Heute ist dein MRT-Termin, hier ist eine Checkliste für heute',
          scheduledDate:
              selectedDate //selectedDate.add(const Duration(seconds:2)),
          );
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Hinweis()));
    }
  }

  bool get valid => clicked != false;

  @override
  Widget build(BuildContext context) {
    if (clicked == true) {
      final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
      final box = state.data.mrtDate;
      selectedDate = box!;
      print('selected date' + selectedDate.toString());
    }
    return GeneralLayout(
      showBackButton: true,
      title: "Dein MRT-Termin",
      child: Column(
        children: [
          ContentBox(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              // Falls schon eins ausgefwählt wurde selectedDate auf das setzten
              SizedBox(
                height: 20.0,
              ),
              Text(
                "${selectedDate.toLocal()} ".split(' ')[0],
                style: Theme.of(context).textTheme.headline5,
              ),

              SizedBox(
                height: 20.0,
              ),
              SecondaryButton(
                onPressed: () => _selectDate(context),
                child: const Text('Wähle ein Datum aus'),
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
          PrimaryButton(
            onPressed: valid ? submit : null,
            child: const Text("Bestätigen"),
          ),
        ],
      ),
    );

    /*Container(
        child: LayoutBuilder(builder: ( context,constraints){

        if(state.toString() == "ReampStateLoaded"){ 
        final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;
        final  box = state.data.mrtDate;
        selectedDate= box!;
        print('selected date'+ selectedDate.toString());

  }

          
          //else{selectedDate = DateTime.now();}
return _datePageLayout();
        ),),*/
  }

  /*

  @override
  Widget build(BuildContext context) {
     return GeneralLayout(
      showBackButton: true,
      title: "Dein MRT-Datum",
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContentBox(
              child: Column(children: [
          Text(
                 "Hattest du schon einmal eine unkontrollierbare Panikattacke oder befindest dich zur Zeit in psychatrischer oder psychotherapeutischer Behandlung?",
                style:Theme.of(context).textTheme.bodyText1,
          ),
        
          const SizedBox(height: 30.0),
          Row(
            children: [
              [
                Checkbox(
                  value: panic ?? false,
                  onChanged: (_) => setState(() => panic = true),
                ),
                const Text("Ja"),
              ],
              [
                Checkbox(
                  value: !(panic ?? true),
                  onChanged: (_) => setState(() => panic = false),
                ),
                const Text("Nein"),
              ],
            ].map<Widget>((l) => Expanded(child: Row(children: l))).toList(),
          ),

          ],),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: PrimaryButton(
              onPressed:   valid ? submit : null,
              child: const Text("Bestätigen"),
            ),
          ),
        ],
      ),
     );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }*/
}
