import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'items.dart';

class Uhome extends StatefulWidget {
  const Uhome({Key? key}) : super(key: key);

  @override
  State<Uhome> createState() => _UhomeState();
}

class _UhomeState extends State<Uhome> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _eventController = TextEditingController();

//  void _read() async {
//      DocumentSnapshot documentSnapshot;
//       documentSnapshot = await firestore.collection('announcement').doc('').get();
//       // CollectionReference _collectionRef = FirebaseFirestore.instance.collection('name').doc('n001').get();
//       var info = firestore.collection('announcement');
//       var docSnapshot = await info.doc('new announcement').get();
//       if (docSnapshot.exists) {
//         Map<String, dynamic>? data = docSnapshot.data();
//         var announcement= data?['new announcement'];
//         _showDialog(new announcement);
//       }
// }
// // check balik
// void _showDialog(String announcement) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("TUTOR DETAILS", textAlign: TextAlign.center),
//           content: new Text(' Full name: $fullname \n IC number: $icno \n Contact number: $contactno \n Email: $email \n Subject offered: $subject'),
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
  FirebaseFirestore db = FirebaseFirestore.instance;
  void _retireve(focusDay) async{
    var info = await db.collection('event').where("date", isEqualTo: focusDay).get();
    var data = info.docs.map((doc) => doc.data()).toList();
    var length = data.length;
    var event = data[0]['eventname'];
    String? text = '';
    // print(length);
    for (var i = 0; i < length; i++) {
      String info = data[i]['eventname'];
  
      text = text!+'\n'+info;
    }
    _showDialog(text);
  }
  void _showDialog(var text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Event Information", textAlign: TextAlign.center),
          content: new Text(text),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Homepage'),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.login,
                        );
                      })),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 150,
                        width: 250,
                        child: Image.asset('logo.png')),
                    const Text(
                      "Announcement Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 150,
                      width: 300,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Text(
                            "Announcement" * 20,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2050),
                        calendarFormat: format,
                        onFormatChanged: (CalendarFormat _format) {
                          setState(() {
                            format = _format;
                          });
                        },
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        daysOfWeekVisible: true,

                        //Day Changed
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                          });
                          _retireve(focusedDay);
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },

                        //To style the Calendar
                        calendarStyle: const CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            shape: BoxShape.circle,
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
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
              tileColor: Colors.blue,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.uhome,
                );
              }),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Tournament'),
              onTap: () async{
                var info = await db.collection("event").get();
                data = info.docs.map((doc) => doc.id.toString()).toList();
                var tour = await db.collection("tournament").get();
                tourdata = tour.docs.map((doc) => doc.id.toString()).toList();
                Navigator.pushNamed(
                  context,
                  Routes.tournament,
                  arguments: Items(
                    item: data,
                    tour: tourdata
                    ),
                );
                // Navigator.pushNamed(
                //   context,
                //   Routes.utournament,
                // );
              }),
          ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ugallery,
                );
              }),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.login,
                );
              }),
        ],
      ),
    );
  }
}
