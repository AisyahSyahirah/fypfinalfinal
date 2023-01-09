import 'package:flutter/material.dart';
import 'routes.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'items.dart';
import 'announcement.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var event, tournament, rank, name, participants;

  void _setevent(String text) {
    setState(() {
      event = text;
    });
  }

  void _settournament(String text) {
    setState(() {
      tournament = text;
    });
  }

  void _setrank(String text) {
    setState(() {
      rank = text;
    });
  }

  void _setname(String text) {
    setState(() {
      name = text;
    });
  }

  void _setparticipants(String text) {
    setState(() {
      participants = text;
    });
  }

  void _update() async {
    try {
      await firestore.collection('event').doc().update({
        'eventname': "",
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
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
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: const Text(
          //     "Event:",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ), //kat sini nak panggil balik event yg dia choose kat dropdown tadi
          // ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: const Text(
          //     "Tournament:",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ), //kat sini nak panggil balik tournament yg dia choose kat dropdown tadi
          // ),
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
          Container(
              width: 10,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  child: const Text('Add name'),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Add name"),
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
          Container(
              width: 10,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text('Add participant'),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Add participant"),
                          content: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
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

//sidebar menu
class NavDrawer extends StatelessWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> data = [];
  List<String> tourdata = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(padding: const EdgeInsets.all(20)),
          SizedBox(height: 50, width: 50, child: Image.asset('logo.png')),
          Container(padding: const EdgeInsets.all(20)),
          ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Home'),
              onTap: () async {
                String? annc = '';
                var ann = await db.collection('announcement').get();
                var annData = ann.docs.map((doc) => doc.data()).toList();
                var length = annData.length;
                for (var i = 0; i < length; i++) {
                  String data = annData[i]['newannouncement'];
                  var number = i + 1;
                  annc = annc! + '\n $number : ' + data;
                }
                Navigator.pushNamed(context, Routes.home,
                    arguments: Announcement(announcement: annc));
              }),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Tournament'),
              tileColor: Colors.blue,
              onTap: () async {
                var info = await db.collection("event").get();
                data = info.docs.map((doc) => doc.id.toString()).toList();
                var tour = await db.collection("tournament").get();
                tourdata = tour.docs.map((doc) => doc.id.toString()).toList();
                Navigator.pushNamed(
                  context,
                  Routes.tournament,
                  arguments: Items(item: data, tour: tourdata),
                );
              }),
          ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.gallery,
                );
              }),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () async {
                String? annc = '';
                var ann = await db.collection('announcement').get();
                var annData = ann.docs.map((doc) => doc.data()).toList();
                var length = annData.length;
                for (var i = 0; i < length; i++) {
                  String data = annData[i]['newannouncement'];
                  annc = annc! + '\n' + data;
                }
                Navigator.pushNamed(context, Routes.uhome,
                    arguments: Announcement(announcement: annc));
              }),
        ],
      ),
    );
  }
}
