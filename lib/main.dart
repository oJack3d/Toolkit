import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/cameraPage.dart';
import 'package:toolkit/compasPage.dart';
import 'package:toolkit/flashlightPage.dart';
import 'package:toolkit/notePage.dart';
import 'package:toolkit/notificationPage.dart';
import 'package:toolkit/soundboardPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  var notes = Notes();
  runApp(MyApp(notes));
}

class Notes extends ChangeNotifier {
  SharedPreferences _prefs;
  List<String> _notes;

  Future<void> initNotes() async {
    _prefs = await getPrefs();
    _notes = _prefs.getStringList('notes') ?? [];
  }

  Future<SharedPreferences> getPrefs() async{
    return await SharedPreferences.getInstance();
  }

  List<String> get notes => List.unmodifiable(_notes);
}

class MyApp extends StatelessWidget {
  Notes notes;
  MyApp(this.notes);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Notes>(
      create: (_) => notes,
      child: MaterialApp(
      title: 'Toolkit',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    ));
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
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
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
              Center(
                child: Text(title,
                    style:
                    TextStyle(fontSize: 18.0, color: Colors.black)),
              )
            ],
          ),
        ),
      ));
}