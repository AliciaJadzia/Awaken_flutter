import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Awaken());
}

class Awaken extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AwakenState createState() => _AwakenState();
}

class _AwakenState extends State<Awaken> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //final firestoreInstance = FirebaseFirestore.instance;

  String documentID;
  void login(String mail, String pass) async {
    print('called');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pass);
      print('Signed in!');
      documentID = userCredential.user.photoURL;
      String nickname = userCredential.user.displayName;
      print("Nickname: $nickname Document id: $documentID");
      FlutterRingtonePlayer.playNotification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void setAlarm(int hour, int minute, String buddyID) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentID)
        .update({'alarm_hour': hour, 'alarm_minute': minute, 'buddy': buddyID });
    print('Alarm set');
    FlutterRingtonePlayer.playNotification();
  }

  void iAmAwake() {
    var now = DateTime.now();
    print('called, awake $now');
    // TODO: Send time event to firebase.
    FlutterRingtonePlayer.playNotification();
  }

  void playAlarm() {
    FlutterRingtonePlayer.playAlarm();
  }

  String emailText;

  String pwdText;

  String buddyID;

  String hour;

  String minute;

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
                onChanged: (newText) {
                  emailText = newText;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (newText) {
                  pwdText = newText;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  login(emailText, pwdText);
                },
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
                onChanged: (newText) {
                  buddyID = newText;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Buddy Email',
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
                      onChanged: (newText) {
                        hour = newText;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Hour'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (newText) {
                        minute = newText;
                      },
                      decoration: InputDecoration(labelText: 'Minute'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () { setAlarm(int.parse(hour), int.parse(minute), buddyID); },
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
