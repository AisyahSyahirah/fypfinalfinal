import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Tournament extends StatefulWidget {
  const Tournament({Key? key}) : super(key: key);

  @override
  State<Tournament> createState() => _TournamentState();
}

class _TournamentState extends State<Tournament> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var event;
  var tournament;

  // void _seticno(String text) {
  //   setState(() {
  //     icno = text;
  //   });
  // }

  void _read() async {
    //  DocumentSnapshot documentSnapshot;
    //   documentSnapshot = await firestore.collection('tutor').doc(icno).get();
      //CollectionReference _collectionRef = FirebaseFirestore.instance.collection('name').doc('aisyah').get();
      var info = firestore.collection('event');
      var docSnapshot = await info.doc(event).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var event = data?['event'];
        var tournament = data?['tournament'];
  }

  // void _showDialog(String fname, ic, contact, mail, sub) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("TUTOR DETAILS", textAlign: TextAlign.center),
  //        content: new Text(' Full name: $fname \n \n IC number: $icno \n \n Contact number: $contact \n \n Email: $mail \n \n Subject offered: $sub'),
  //         actions: <Widget>[
  //           new TextButton(
  //             child: new Text("Update"),
  //             onPressed: () {
  //               Navigator.pushNamed(
  //                       context,
  //                       Routes.fourthPage,
  //                     );
  //             },
  //           ),


  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(
          child: TournamentState(),
        ),
      ),
    );
  }
}

class _TournamentState  extends StatefulWidget {
  const Tournament({super.key});

  @override
  State<Tournament> createState() => _TournamentState();
}

class _TournamentState extends State<Tournament> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Tournament<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
                 Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: const Text('OK'),
                  )
                ),
  }
}