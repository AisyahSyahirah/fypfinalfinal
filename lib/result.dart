// import 'package:flutter/material.dart';
// import 'routes.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FourthPage extends StatefulWidget {
//   const FourthPage({Key? key}) : super(key: key);

//   @override
//   _FourthPageState createState() => _FourthPageState();
// }

// class _FourthPageState extends State<FourthPage> {
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   var fullname;
//   var icno;
//   var contactno;
//   var email;
//   var subject;
//   var id;

//   void _setfullname(String text) {
//     setState(() {
//       fullname = text;
//     });
//   }

//   void _seticno(String text) {
//     setState(() {
//       icno = text;
//     });
//   }

//   void _setcontactno(String text) {
//     setState(() {
//       contactno = text;
//     });
//   }

//   void _setemail(String text) {
//     setState(() {
//       email = text;
//     });
//   }

//   void _setsubject(String text) {
//     setState(() {
//       subject = text;
//     });
//   }

//   void _create() async {
//     try {
//       await firestore.collection('tutor').doc(icno).set({
//         'fullname': fullname,
//         'icno': icno,
//         'contactno': contactno,
//         'email': email,
//         'subject': subject,
//       });
//       _showDialog(fullname, icno, contactno, email, subject);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _read() async {
//     DocumentSnapshot documentSnapshot;
//     documentSnapshot = await firestore.collection('tutor').doc('n001').get();
//     var info = firestore.collection('tutor');
//     var docSnapshot = await info.doc('fullname').get();
//     if (docSnapshot.exists) {
//       Map<String, dynamic>? data = docSnapshot.data();
//       var fname = data?['fullname'];
//       var ic = data?['icno'];
//       var contact = data?['contactno'];
//       var mail = data?['email'];
//       var sub = data?['subject'];
//       _showDialog(fname, ic, contact, mail, sub);
//     }
//   }

//   void _showDialog(String fname, ic, no, mail, sub) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("TUTOR DETAILS", textAlign: TextAlign.center),
//           content: new Text(' Full name: $fullname \n \n IC number: $icno \n \n Contact number: $contactno \n \n Email: $email \n \n Subject offered: $subject'),
//           actions: <Widget>[
//             new TextButton(child: new Text("Confirm"), onPressed: () {
//                       Navigator.pushNamed(
//                         context,
//                         Routes.secPage,
//                       );
//                     }),
//             new TextButton(
//               child: new Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TUTOR APPLICATION'),
//       ),
//       body: Center(
//           child: Container(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       child: Text('Application form to become a tutor',
//                           style: TextStyle(color: Colors.white)),
//                       color: Colors.pink,
//                       padding: EdgeInsets.all(20.0),
//                       margin: EdgeInsets.all(15.0),
//                     ),
//                     Padding(
//                         padding: EdgeInsets.all(8),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Full name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onChanged: (text) {
//                             _setfullname(text);
//                           },
//                           keyboardType: TextInputType.number,
//                         )),
//                     Padding(
//                         padding: EdgeInsets.all(8),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'IC number',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onChanged: (text) {
//                             _seticno(text);
//                           },
//                           keyboardType: TextInputType.number,
//                         )),
//                     Padding(
//                         padding: EdgeInsets.all(8),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Contact number',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onChanged: (text) {
//                             _setcontactno(text);
//                           },
//                           keyboardType: TextInputType.number,
//                         )),
//                     Padding(
//                         padding: EdgeInsets.all(8),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Email',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onChanged: (text) {
//                             _setemail(text);
//                           },
//                           keyboardType: TextInputType.number,
//                         )),
//                     Padding(
//                         padding: EdgeInsets.all(8),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Subject offered',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onChanged: (text) {
//                             _setsubject(text);
//                           },
//                           keyboardType: TextInputType.number,
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _create();
//                           }
//                         },
//                         child: const Text('Submit'),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ]),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'routes.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result Page'),
        ),
        body: Center(
            child: ListView(children: <Widget>[
          const Text(
            "Result",
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 3),
            textAlign: TextAlign.center,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Event:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), //kat sini nak panggil balik event yg dia choose kat dropdown tadi
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Tournament:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), //kat sini nak panggil balik tournament yg dia choose kat dropdown tadi
          ),
          DataTable(
            columns: const [
              DataColumn(
                  label: Text('Rank',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('Winner')),
                DataCell(Text('yasmin hana')),
              ]),
              DataRow(cells: [
                DataCell(Text('2nd place')),
                DataCell(Text('aisyah')),
              ]),
              DataRow(cells: [
                DataCell(Text('3rd place')),
                DataCell(Text('dibqib')),
              ]),
            ],
          ),
          SizedBox(
              child: ElevatedButton(
                  child: const Text('Add name'),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Add participant"),
                            content: Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle),
                                          labelText: 'Winner',
                                        ),
                                      ),
                                      const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle),
                                          labelText: '2nd Place',
                                        ),
                                      ),
                                      const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle),
                                          labelText: '3rd Place',
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(10)),
                                      ElevatedButton(
                                        child: const Text("Update"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ])),
                          )))),
          DataTable(
            columns: const [
              DataColumn(
                  label: Text('Participants',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('yasmin hana')),
              ]),
              DataRow(cells: [
                DataCell(Text('aisyah')),
              ]),
              DataRow(cells: [
                DataCell(Text('dibqib')),
              ]),
              DataRow(cells: [
                DataCell(Text('yasmin hana')),
              ]),
              DataRow(cells: [
                DataCell(Text('aisyah')),
              ]),
              DataRow(cells: [
                DataCell(Text('dibqib')),
              ]),
            ],
          ),
          SizedBox(
              child: ElevatedButton(
            child: const Text('Add participant'),
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Add participant"),
                      content: TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    )),
          )),
          Container(padding: const EdgeInsets.all(20))
        ])));
  }
}