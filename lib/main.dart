import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void login() {
    print('called');
    // TODO: Send login to firebase
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
          padding: const EdgeInsets.all(15.0),
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
                child: Text('Log in',
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: iAmAwake,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black38, // background
                  onPrimary: Colors.lightBlueAccent, // foreground
                ),
                child: Text(
                  'I am Awake',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
