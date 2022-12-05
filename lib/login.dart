
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

  var password;
  
  void _setPass(String text) {
    setState(() {
      password = text;
    });
  }

  void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: "iseiium@gmail.com",
            password: password);
      Navigator.pushNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        
      ),body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: <Widget>[
          Form(
            key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child:TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password'
                    ),
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }, 
                    onChanged: (text) {
                      _setPass(text);
                    },
                  )
                ),

                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: const Text('Login'),
                  )
                ),

                ],
            )
          ),
        ]),
      ),);
  }
}