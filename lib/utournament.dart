import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Utournament extends StatefulWidget {
  const Utournament({Key? key}) : super(key: key);

  @override
  State<Utournament> createState() => _UtournamentState();
}

class _UtournamentState extends State<Utournament> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _read() async {
    DocumentSnapshot documentSnapshot;
    documentSnapshot =
        await firestore.collection('event').doc('eventname').get();
    var info = firestore.collection('event');
    var docSnapshot = await info.doc('eventname').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var event = data?['eventname'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tournament Page'),
      ),
      body: Center(
        child: DropdownButtonHideUnderline(
            child: Column(
          children: <Widget>[
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
                items: items
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
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
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
                  items: items
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
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
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
                )),
            Container(padding: const EdgeInsets.all(10)),
            SizedBox(
                height: 30,
                width: 100,
                child: ElevatedButton(
                    child: const Text('Search'),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.uresult,
                      );
                    })),
          ],
        )),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
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
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.uhome,
                );
              }),
          ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Tournament'),
              tileColor: Colors.blue,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.utournament,
                );
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
