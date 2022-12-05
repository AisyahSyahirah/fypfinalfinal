import 'package:flutter/material.dart';
import 'package:tutor/home.dart';
import 'routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
/////
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Homepage'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                    child: const Text('LOGIN FOR ADMIN'),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.login,
                      );
                    })),
            Container(
              child: Text('ANNOUNCEMENTS'),
              decoration:
                  BoxDecoration(shape: BoxShape.rectangle, color: Colors.green),
              padding: EdgeInsets.all(70.0),
              margin: EdgeInsets.all(15.0),
            )
          ],
        ),
      )),
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
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/Dekstop/ISEIIUM.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Event'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Result'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Gallery'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}