import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'items.dart';
import 'announcement.dart';

class Ugallery extends StatefulWidget {
  const Ugallery({Key? key}) : super(key: key);

  @override
  State<Ugallery> createState() => _UgalleryState();
}

class _UgalleryState extends State<Ugallery> {
  final List<String> imageList = [
    "https://www.iium.edu.my/imagecache/original/64154/LED_1024x768.jpeg",
    "https://www.iium.edu.my/media/59407/IDUS%20Celebration.jpg",
    "https://www.iium.edu.my/imagecache/large/78420/NEW%20COACHING%20POSTER%20%28Instagram%20Post%29%20%281%29.png"
     ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text("Tournament Gallery"),
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
    );
  }
}

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
          SizedBox(height: 50, width: 50, child: Image.asset('assets/logo.png')),
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
                Navigator.pushNamed(context, Routes.uhome,
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
                  Routes.utournament,
                  arguments: Items(item: data, tour: tourdata),
                );
                // Navigator.pushNamed(
                //   context,
                //   Routes.utournament,
                // );
              }),
          ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Gallery'),
              tileColor: Colors.blue,
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
