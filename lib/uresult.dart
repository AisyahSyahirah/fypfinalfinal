import 'package:flutter/material.dart';
import 'routes.dart';

class Uresult extends StatefulWidget {
  const Uresult({Key? key}) : super(key: key);

  @override
  State<Uresult> createState() => _UresultState();
}

class _UresultState extends State<Uresult> {
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
          Container(padding: const EdgeInsets.all(20))
        ])));
  }
}