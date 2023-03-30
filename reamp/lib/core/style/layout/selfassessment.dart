import 'package:flutter/material.dart';
import 'package:reamp/core/config/theme.dart';

class SelfAssessLayout extends StatelessWidget {
  final Widget child;
  final String pageid;
  
  

  const SelfAssessLayout({
    required this.child,
    required this.pageid,

    Key? key,
  }) : super(key: key);


  Widget _buildInfo(BuildContext context) {
    return AlertDialog(
      title: const Text("Selbsteinschätzung"),
      content: const Text("Damit REAMP dir helfen kann deine Angst zu überwinden, wollen wir dir einen persönlichen Therapieplan erstellen. Dafür werden dir Fragen zu den Themen MRT und Angst gestellt. Bitte nimm dir ca 10 min Zeit, um die Selbsteinschätzung abzuschließen. Nach der Selbsteinschätzung erstellt dir REAMP deinen persönlichen Therapieplan."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Verstanden"),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:CustomPaint(
        painter: BackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(width: 15.0),
              Row(children: [
                Text(
                "Onboarding",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ), 
              const Spacer(),
              getWidget(),
              
            

            

              ]),
              const SizedBox(height: 10.0),
              Row(children: [
                  Text(
                "Selbsteinschätzung",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
              IconButton(
                icon: const Icon(Icons.info),
                  color: Colors.blue[700],
                  iconSize: 26,
                  onPressed: () {
                    showDialog(context: context, builder: _buildInfo);

                  },)
              ],),
             
              child,
           ],
              ),
         
          ),
        
        )
       

                  );
                 
                
              
  }

 Widget getWidget() {
// for schleife durch Liste mit Ids und wenn gleich uahl ansonsten grauer booble -> kürzerer Code 

   if(pageid=="1"){
     return Row(children: [
       Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),  
                child: Text(pageid, style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
              const SizedBox(width: 5.0),
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
              const SizedBox(width: 5.0),
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
              const SizedBox(width: 5.0),
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
     ]);
   }
     if(pageid=="2"){
     return Row(children: [
        Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
       const SizedBox(width: 5.0),
       Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),  
                child: Text(pageid, style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
            
            
              const SizedBox(width: 5.0),
              
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
              
              const SizedBox(width: 5.0),
              
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
     ]);
 }
if(pageid=="3"){
     return Row(children: [

              Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
          const SizedBox(width: 5.0),
        Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
       const SizedBox(width: 5.0),
       Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),  
                child: Text(pageid, style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
            
            
              
              const SizedBox(width: 5.0),
              
               Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
     ]);
}

else{
  return Row(children: [

        Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
        const SizedBox(width: 5.0),
        Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
        const SizedBox(width: 5.0),
        Icon(Icons.circle,
              size:12,
               color: Colors.grey[300],
              ),
        const SizedBox(width: 5.0),
        Container( alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                //I used some padding without fixed width and height
                decoration:BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: ReampColors.primary,
                ),  
                child: Text(pageid, style: TextStyle(color: Colors.orange[800], fontSize: 15.0),textAlign: TextAlign.right ,),
                      ),
            
            
     ]);
 }

}
}

  class BackgroundColor extends CustomPainter {
  //final double offset;

  //BackgroundColor(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()..color = ReampColors.primary;
    final rect = Rect.fromLTWH(-(size.height/42)* (size.width/18), -(size.height/1.2), (size.height) , (size.height));
    canvas.drawOval(rect, painter);
  }

  @override
  bool shouldRepaint(BackgroundColor oldDelegate) {
    return false;
  }
}
