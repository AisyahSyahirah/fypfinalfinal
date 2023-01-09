import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'announcement.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Gallery Page'),
      ),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
          items: imageList
              .map((e) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          e,
                          width: 1050,
                          height: 350,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              width: 50,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  child: const Text('Upload photo'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.gallery,
                    );
                  }),
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
          ),
        ),
        label: const Text("Add Photo"),
        icon: const Icon(Icons.add),
      ),
    );
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
              tileColor: Colors.blue,
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
