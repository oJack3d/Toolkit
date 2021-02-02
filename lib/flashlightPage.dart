import 'package:flashlight/flashlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlashLight extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FlashLight();
  }
}

class _FlashLight extends State<FlashLight>{
  bool hasFlashLight = false; //to set is there any flashlight ?
  bool isOn = false; //to set if flash light is on or off
  IconData icon = Icons.wb_sunny_outlined; //icon for flashlight button
  Color color = Colors.red; //color for flash button

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      //we use Future.delayed because there is async function inside it.
      bool istHereLight = await Flashlight.hasFlashlight;
      setState(() {
        hasFlashLight = istHereLight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(title:Text("Taschenlampe")),
        body: Container(
          width:double.infinity,
          height:MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          //set width and height of outermost wrapper to 100%;
          child:flashlightbutton(),
        )
    );
  }

  Widget flashlightbutton(){
    if(hasFlashLight){
      return Column(children: <Widget>[
        Text(isOn ? "ON" : 'OFF'),

        Container(
            child: FlatButton.icon(
              height: 50,
              onPressed: (){
                if(isOn){
                  //if light is on, then turn off
                  Flashlight.lightOff();
                  setState(() {
                    isOn = false;
                    icon = Icons.wb_sunny_outlined;
                    color = Colors.red;
                  });
                }else{
                  //if light is off, then turn on.
                  Flashlight.lightOn();
                  setState(() {
                    isOn = true;
                    icon = Icons.wb_sunny;
                    color = Colors.greenAccent;
                  });
                }
              },
              icon: Icon(icon, color: Colors.white),
              color: color,
              label: Text(isOn ? 'TURN OFF' : 'TURN ON',
                style: TextStyle(color: Colors.white),
              ),

            )
        )

      ],);
    }else{
      return Text("Your device do not have flash light.");
    }
  }

}