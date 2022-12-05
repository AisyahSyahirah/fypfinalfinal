//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'login.dart';
import 'home.dart';
import 'tournament.dart';
import 'result.dart';
//import 'gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCLGj-538qvfT_x3B14I8ano8gzN3FAbE8",
      appId: "1:807137615655:android:f5a883aa517eb5718c9302",
      messagingSenderId: "807137615655",
      projectId: "fypreal-55a12",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sports Event System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: Routes.login ,
        routes: {
          Routes.login: (context) => Login(),
          Routes.home: (context) =>  Home(),
          //Routes.tournament: (context) => const Tournament(),
          //Routes.result: (context) => const Result(),
          //Routes.gallery: (context) => const Gallery(),
        });
  }
}

