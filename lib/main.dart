import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:toolkit/cameraPage.dart';
import 'package:toolkit/compasPage.dart';
import 'package:toolkit/flashlightPage.dart';
import 'package:toolkit/notePage.dart';
import 'package:toolkit/notificationPage.dart';
import 'package:toolkit/soundboardPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  var notes = NotePage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolkit',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolkit'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem("Lupe", Icons.zoom_in, context),
            makeDashboardItem("Taschenlampe", Icons.wb_incandescent, context),
            makeDashboardItem("Notizen", Icons.auto_stories, context),
            makeDashboardItem("Benachrichtigung", Icons.announcement_outlined, context),
            makeDashboardItem("Kompass", Icons.assistant_navigation, context),
            makeDashboardItem("Soundboard", Icons.surround_sound_outlined, context)
          ],
        ),
      ),
    );
  }
}

Card makeDashboardItem(String title, IconData icon, BuildContext context) {
  return Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: new InkWell(
          onTap: () {
            if (title == 'Lupe')
               Navigator.of(context).push(
                   MaterialPageRoute(
                      builder: (_) => CameraPage()
                   )
               );
            else if (title == 'Notizen')
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => NotePage()
                  )
              );
            else if (title == 'Benachrichtigung')
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => NotificationPage()
                  )
              );
            else if (title == 'Kompass')
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => CompassPage()
                  )
              );
            else if (title == 'Soundboard')
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => Soundboard()
                  )
              );
            else
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => FlashLight()
                  )
              );
             },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                  child: Icon(
                    icon,
                    size: 40.0,
                    color: Colors.black,
                  )),
              SizedBox(height: 20.0),
              new Center(
                child: new Text(title,
                    style:
                    new TextStyle(fontSize: 18.0, color: Colors.black)),
              )
            ],
          ),
        ),
      ));
}