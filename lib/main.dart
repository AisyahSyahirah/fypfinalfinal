import 'package:flutter/material.dart';
import 'routes.dart';
import 'home.dart';
import 'login.dart';
import 'tournament.dart';
import 'result.dart';
import 'gallery.dart';
import 'uhome.dart';
import 'utournament.dart';
import 'uresult.dart';
import 'ugallery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   runApp(const MyApp());
// }
  
  void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyCLGj-538qvfT_x3B14I8ano8gzN3FAbE8",
      appId: "1:807137615655:android:f5a883aa517eb5718c9302",
      messagingSenderId: "807137615655",
      projectId: "fypreal-55a12",)
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
          primaryColor: Colors.lightBlue,

          // Define the default font family.
          fontFamily: 'Georgia',
        ),
        initialRoute: Routes.uhome,
        routes: {
          Routes.home: (context) => const Home(),
          Routes.login: (context) => const Login(),
          Routes.tournament: (context) => const Tournament(),
          Routes.result: (context) => const Result(),
          Routes.gallery: (context) => const Gallery(),
          Routes.uhome: (context) => const Uhome(),
          Routes.utournament: (context) => const Utournament(),
          Routes.uresult: (context) => const Uresult(),
          Routes.ugallery: (context) => const Ugallery(),
        });
  }
}