import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettingsMacOS = MacOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Benachrichtigung'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                onPressed: _showNotification,
                child: Text('Notification'),
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                onPressed: _notificationWithSound,
                child: Text('Notification mit Ton'),
              ),
            ],
          ),
        ),
      );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('id', 'name', 'description', playSound: false, /*sound: RawResourceAndroidNotificationSound(null),*/ importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    // todo: Every button takes the correct function, but if you first pick the function without sound both buttons play no sound and otherwise...!
    // print('no sound');
    await flutterLocalNotificationsPlugin.show(
      0,
      'Erinnerung',
      'Erinnerungstext',
      platformChannelSpecifics,
      payload: 'no sound',
    );
  }

  Future _notificationWithSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('id', 'name', 'description', sound: RawResourceAndroidNotificationSound('salamisound'), importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    // print('sound');
    await flutterLocalNotificationsPlugin.show(
      0,
      'Erinnerung!',
      'Erinnerungstext mit Ton',
      platformChannelSpecifics,
      payload: 'salami sound',
    );
  }
}