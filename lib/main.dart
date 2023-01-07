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

void main() async {
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