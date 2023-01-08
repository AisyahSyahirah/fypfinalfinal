import 'package:flutter/material.dart';
import 'package:tutor/home.dart';
import 'routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final _formKey = GlobalKey<FormState>();
   FirebaseAuth auth = FirebaseAuth.instance;

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
            email: "iseiium@gmail.com",
            password: "iseiium");
      Navigator.pushNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  
   void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Subscribe using email to get notifications",
                textAlign: TextAlign.center),
            content: TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onChanged: (text) {
                _setEmail(text);
              },
            ),
            actions: [
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.uhome,
                    );
                  }),
              TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.uhome,
                    );
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 100, width: 300, child: Image.asset('logo.png')),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Admin password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    _setPass(text);
                  },
                )),
            SizedBox(
                height: 40,
                width: 250,
                child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.home,
                      );
                    })),
            Container(
                padding: const EdgeInsets.all(20),
                child: TextButton(
                    child: const Text('Not an admin? | Continue as guest',
                        style: TextStyle(decoration: TextDecoration.underline)),
                    onPressed: _showDialog)),
          ],
        ),
      )),
    );
  }
}