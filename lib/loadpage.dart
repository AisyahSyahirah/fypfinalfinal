import 'package:flutter/material.dart';
import 'package:tutor/home.dart';
import 'routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'items.dart';
import 'announcement.dart';
import 'main.dart';

class loadpage extends StatefulWidget {
  const loadpage({Key? key}) : super(key: key);

  @override
  State<loadpage> createState() => _loadpagestate();
}

class _loadpagestate extends State<loadpage> {
  @override
  Widget build(BuildContext context) {
    String? annc = '';
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Homepage'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
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
                  },
                  child: const Text('Continue'),
                ),
              )
            ]),
      ),
    );
  }
}
