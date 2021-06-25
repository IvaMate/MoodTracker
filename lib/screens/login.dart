import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loginKey = GlobalKey<FormState>();
  String _email = '', _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'lib/Images/fenix.png',
                width: 100.0,
              ),
              new Text('PRIJAVA',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 20.0,
              ),
              new Text('E-mail',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              Form(
                key: loginKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _email,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Morate unijeti e-mail adresu';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _email = value!;
                        });
                      },
                    ),
                    new Text('Lozinka',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    TextFormField(
                      initialValue: _password,
                      obscureText: true,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Morate unijeti e-mail adresu';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _password = value!;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () async {
                          if (loginKey.currentState!.validate()) {
                            loginKey.currentState!.save();
                            User user = await _login(e: _email, p: _password);
                            if (user != null) {
                              if (user != null) {
                                Navigator.pushReplacementNamed(context, '/home',
                                    arguments: user);
                              }
                            }
                          }
                        },
                        child: Text('Login'),
                        style: ButtonStyle()),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: Text('ili se registriraj..'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<User> _login({String e = '', String p = ''}) async {
    UserCredential userCred = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: e, password: p);
    return userCred.user!;
  }
}
