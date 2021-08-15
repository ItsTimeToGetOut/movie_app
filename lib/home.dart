import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'backend.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState

    Firebase.initializeApp();
    super.initState();
  }

  var email = "";
  var password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (v) {
                  email = v;
                },
                decoration: InputDecoration(
                  labelText: 'enter your email',
                ),
              ),
              TextField(
                onChanged: (v) {
                  password = v;
                },
                decoration: InputDecoration(
                  labelText: 'enter your password',
                ),
              ),
              Center(
                child: TextButton(
                  child: Text('Login'),
                  onPressed: () async {
                    if (email != null && password != null)
                      await loginAttempt(email, password);
                    var a = await query();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dashboard(
                                a: a,
                              )),
                    );
                  },
                ),
              ),
              Center(child: Text('Don\'t have an account yet? create one!')),
              TextField(
                onChanged: (v) {
                  email = v;
                },
                decoration: InputDecoration(
                  labelText: 'enter your email',
                ),
              ),
              TextField(
                onChanged: (v) {
                  password = v;
                },
                decoration: InputDecoration(
                  labelText: 'enter your password',
                ),
              ),
              Center(
                child: TextButton(
                  child: Text('Register'),
                  onPressed: () async {
                    if (email != null && password != null)
                      await registrationAttempt(email, password);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
