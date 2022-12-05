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
        var fname = data?['event'];
        var ic = data?['tournament'];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISE Eye'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children : 
              StreamBuilder<QuerySnapshot>(  
               stream: Firestore.instance.collection('sport').snapshots(), builder: (context, snapshot) {
               if (!snapshot.hasData)
               return Center(
               child: CupertinoActivityIndicator(),
              );

               return Container(
               padding: EdgeInsets.only(bottom: 16.0),
               child: Row(
               children: <Widget>[
               Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                    child: Text(
                      "Event",
                    ),
                  )),
               new Expanded(
                flex: 4,
                child: DropdownButton(
                  value: eventname,
                  isDense: true,
                  onChanged: (valueSelectedByUser) {
                    _onShopDropItemSelected(valueSelectedByUser);
                  },
                  hint: Text('Select Event'),
                  items: snapshot.data.documents
                      .map((DocumentSnapshot document) {
                    return DropdownMenuItem<String>(
                      value: document.data['event name'] +
                          ' ' +
                          document.data['shop_type'],
                      child: Text(document.data['plant_name'] +
                          ' ' +
                          document.data['shop_type']),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      });
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
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}