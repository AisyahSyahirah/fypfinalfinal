import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor/items.dart';
import 'routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'items.dart';
import 'announcement.dart';

class Tournament extends StatefulWidget {
  const Tournament({Key? key}) : super(key: key);

  @override
  State<Tournament> createState() => _TournamentState();
}

class _TournamentState extends State<Tournament> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var data, event, tour;
  String? selectedValueEvent;
  String? selectedValueTour;
  void setEvent(text) {
    setState(() {
      event = text;
    });
  }

  void setTour(text) {
    tour = text;
  }

  void createEvent() {
    db.collection('event').doc(event).set({});
  }

  void createTour() {}

  @override
  Widget build(BuildContext context) {
    final Items items = ModalRoute.of(context)!.settings.arguments as Items;
    List<String> event = items.item;
    List<String> tour = items.tour;
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Tournament Page'),
        ),
        body: Center(
            child: DropdownButtonHideUnderline(
                child: Column(children: <Widget>[
          const Text("Select tournament and event",
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 8, fontSize: 20)),

          //dropdown event
          Container(
            padding: const EdgeInsets.all(20),
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Event',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: event
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedValueEvent,
              onChanged: (value) {
                setState(() {
                  selectedValueEvent = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 250,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.blueAccent,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 300,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.blueGrey,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
            ),
          ),
          TextButton(
            child: const Text(
              "Add Event",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Add Event"),
                content: TextFormField(
                  decoration: const InputDecoration(labelText: 'Event'),
                  onChanged: (text) {
                    setEvent(text);
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        createEvent();
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),

          //dropdown tournament
          Container(
            padding: const EdgeInsets.all(20),
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Tournament',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: tour
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selectedValueTour,
              onChanged: (value) {
                setState(() {
                  selectedValueTour = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: 250,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.blueAccent,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 300,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.blueGrey,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(-20, 0),
            ),
          ),
          TextButton(
            child: const Text(
              "Add Tournament",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Add Tournament"),
                      content: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Tournament'),
                        onChanged: (text) {
                          setTour(text);
                        },
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                            child: const Text("Ok"),
                            onPressed: () {
                              createTour();
                              Navigator.pop(context);
                            }),
                      ],
                    )),
          ),
          Container(padding: const EdgeInsets.all(10)),
          SizedBox(
              height: 30,
              width: 100,
              child: ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.result,
                    );
                  })),
        ]))));
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
                  annc = annc! + '\n' + data;
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
                // Navigator.pushNamed(
                //   context,
                //   Routes.tournament,
                // );
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
                  var number = i + 1;
                  annc = annc! + '\n $number : ' + data;
                }
                Navigator.pushNamed(context, Routes.uhome,
                    arguments: Announcement(announcement: annc));
              }),
        ],
      ),
    );
  }
}
