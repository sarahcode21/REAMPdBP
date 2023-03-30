import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/layout/selfassessment.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/page/onboarding/assessment2.dart';
import 'package:reamp/page/onboarding/assessment4.dart';
import 'package:reamp/page/onboarding/plan.dart';
import 'package:reamp/page/onboarding/privacy.dart';
import 'package:reamp/page/onboarding/videoplayer.dart';


class  OnboardingAssessment3 extends StatelessWidget {
  const OnboardingAssessment3({ Key? key }) : super(key: key);

    void initState(){
    setPortrait();
  }


  Future setPortrait() async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
      ]);
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
                ]);
    
    return SelfAssessLayout(
      pageid: "3",
      child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        
        
        children: [
        
     /* body: CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 15.0),
              Padding(padding: const EdgeInsets.only(top:30.0 ,left:15),
              child:Text(
                "Onboarding",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
              
              ),
              const SizedBox(height:35.0),
              Padding(padding: const EdgeInsets.only(left:15),
              child: Row(children: [
                          Text(
                            "Selbsteinschätzung",
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.left,
              ),
               IconButton(
                icon: Icon(Icons.info),
                  color: Colors.blue[700],
                  iconSize: 26,
                  onPressed: () {

                  },)  */  
              
              
                Text(
                "MRT-Untersuchung",
                 style: Theme.of(context).textTheme.headline6?.apply(color:Colors.blue[700]),
                 ),
              
              const SizedBox(height:5),
                 Text(
                "Im Folgendem zeigen wir dir ein Video, das eine MRT-Untersuchung mit typischer Geräuschkulisse zeigt.",
                 style: Theme.of(context).textTheme.bodyText2,

                 ),
             
               // const SizedBox(height: 10.0),
              /* Row(
               //  mainAxisAlignment: MainAxisAlignment.start,
                 
                 children: [
                      IconButton(
                      icon: Icon(Icons.info),
                        color: Colors.blue[700],
                        iconSize: 20,
                        onPressed: () {

                        },),
                        Flexible(
                          child: */
                          Text(
                            "Solltest du dich unwohl fühlen, kannst du das Video jederzeit anhalten oder abbrechen.",
                            style: Theme.of(context).textTheme.bodyText2?.apply(color:Colors.blue[700]),
                          ),
                         
              
                 
              const SizedBox(height: 20.0), 
              Container(
                height:  200,//MediaQuery.of(context).size.height /3.3,
                width: double.infinity,
                child: AssetPlayerWidget(classname: 'assessment3'),
  
              ),
         
              //Image.asset('/Users/sarahseidnitzer/REAMP/reamp-proto/reamp/assets/img/preview_mrt_room_near.jpg'),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child:PrimaryButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const  OnboardingAssessment4())),
                      child: const Text("Weiter"),
                    ),
              ),
             // const SizedBox(height: 5)
             /*SecondaryButton(
                      child: const Text("Zurück"),
                      margin: EdgeInsets.only(left:20.0),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingAssessment2())),
                    ),*/

            ],
     ), );
  }

  
}

