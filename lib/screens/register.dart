import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/osoba.dart';
import 'package:myapp/services/database.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var registerKey = GlobalKey<FormState>();
  Osoba osoba = Osoba();
  // ignore: unused_field
  String _password = '';
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
              Text('REGISTRACIJA',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 30.0,
              ),
              Form(
                key: registerKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: osoba.email,
                      decoration: InputDecoration(labelText: 'E-mail adresa'),
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Morate unijeti e-mail adresu';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          osoba.email = value!;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Lozinka'),
                      obscureText: true,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Morate unijeti lozinku';
                        }
                        if (value.length < 8) {
                          return 'Lozinka mora sadržavati najmanje 8 znakova';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          _password = value!;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: osoba.ime,
                      decoration: InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null) {
                          return 'Unesite ime';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          osoba.ime = value!;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: osoba.prezime,
                      decoration: InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null) {
                          return 'Unesite prezime';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          osoba.prezime = value!;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () async {
                          if (registerKey.currentState!.validate()) {
                            registerKey.currentState!.save();
                            User user = await _register(osoba, _password);
                            if (user != null) {
                              Navigator.pushReplacementNamed(context, '/home',
                                  arguments: user);
                            }
                          }
                        },
                        child: Text('Registracija'),
                        style: ButtonStyle()),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('ili se prijavi..'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<User> _register(Osoba o, String p) async {
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: o.email, password: p);
    o.id = userCred.user!.uid;
    if (await Database.addUser(o)) {
      print('Novi korisnik je dodan!');
    }
    ;
    return userCred.user!;
  }
}
