import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void login() {
    print('called');
    // TODO: Send login to firebase
  }

  void setAlarm() {
    print('Alarm set');
  }

  void iAmAwake() {
    var now = DateTime.now();
    print('called, awake $now');
    // TODO: Send time event to firebase.
    FlutterRingtonePlayer.playNotification();
  }

  // TODO: implement await for alarm.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Awaken'),
          backgroundColor: Colors.pink,
        ),
        backgroundColor: Colors.grey,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black38, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Buddy User ID',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Alarm (24 hr):',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Hour'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Minute'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: setAlarm,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black38,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              Divider(),
              ElevatedButton(
                onPressed: iAmAwake,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black38, // background
                  onPrimary: Colors.lightBlueAccent, // foreground
                ),
                child: Text(
                  'I am Awake',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
