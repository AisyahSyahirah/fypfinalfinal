import 'package:flutter/material.dart';
import 'package:tutor/home.dart';
import 'routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'announcement.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var password, email;

  void _setPass(String text) {
    setState(() {
      password = text;
    });
  }

  void _setEmail(String text) {
    setState(() {
      email = text;
    });
  }

  void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "iseiium@gmail.com", password: password);
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Login'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100, width: 300, child: Image.asset('assets/logo.png')),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Admin password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        _setPass(text);
                      },
                    ),
                  ])),
            ),
            SizedBox(
                height: 40,
                width: 250,
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                )),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                  child: const Text('Not an admin? | Continue as guest',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  onPressed: () async {
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
            ),
          ],
        ),
      )),
    );
  }
}
