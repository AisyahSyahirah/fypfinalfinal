import 'package:flutter/material.dart';
import 'package:tutor/home.dart';
import 'routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'items.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _eventController = TextEditingController();

  var announcement, focusday, event;
  var data;
  // Event event = new Event();
  void _setEvent(text){
    setState(() {
      event = text;
    });
  }
  void _setdate(focusDay) {
    setState(() {
      focusday = focusDay;
    });
  }

  void _setAnnouncement(String text) {
    setState(() {
      announcement = text;
    });
  }

  void _create() async {
    try {
      await firestore.collection('announcement').doc().set({
        'newannouncement': event,
        'date' : focusday
      });
      // _showDialog();
    } catch (e) {
      print(e);
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:
                  const Text("Add Announcements", textAlign: TextAlign.center),
              content: TextFormField(
                decoration: const InputDecoration(labelText: 'Announcement'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Navigator.pop(context);
                  }
                  return null;
                },
                onChanged: (text) {
                  _setAnnouncement(text);
                },
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text("Add"),
                  onPressed: () => Navigator.pop(context),
                ),
              ]);
        });
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
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
        title: const Text('Admin Homepage'),
      ),
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 150, width: 250, child: Image.asset('logo.png')),
                const Text(
                  "Announcement Section",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //
                //announcement
                Container(
                    height: 150,
                    width: 300,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Text(
                            "Announcement" * 20,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                        child: const Text('Add Announcement'),
                        onPressed: _showDialog)),
                //
                //calendar
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
                      // print(focusedDay);
                      _setdate(focusDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },

                    eventLoader: _getEventsfromDay,

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
                ..._getEventsfromDay(selectedDay).map(
                  (Event event) => ListTile(
                    title: Text(
                      event.title,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
              onChanged: (text) {
                _setEvent(text);
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
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  _create();
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
      ),
    );
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
  void read() async {
    // Map<String,dynamic>? info = extract.data();
    // print(info);
    var info = await db.collection("event").get();
    data = info.docs.map((doc) => doc.id.toString()).toList();
    // print(data);
  }

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
                  Routes.home,
                );
              }),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Tournament'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.tournament,
                  arguments: Items(item: data),
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
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.uhome,
                );
              }),
        ],
      ),
    );
  }
}
