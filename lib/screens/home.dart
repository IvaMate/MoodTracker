import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/database.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> boje = [
    Colors.deepPurple,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.red
  ];
  /*Aktivnosti*/
  List<IconData> aktivnosti = [
    Icons.emoji_food_beverage,
    Icons.chrome_reader_mode,
    Icons.run_circle,
    Icons.local_dining_sharp,
    Icons.shopping_bag
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(
          Icons.add_circle,
          size: 50.0,
          color: Colors.blue,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/mood');
        },
      ),
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              new Text('Dnevnik raspoloženja',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  new Text('Vrijeme',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: 100.0,
                  ),
                  new Text('Raspoloženje',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Database.getUserMoods(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return Container(
                    child: new ListView(
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        print(data['mood'].toString());
                        return Row(
                          children: [
                            Expanded(
                              child: Text(data['time'].toDate().toString()),
                              flex: 1,
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.emoji_emotions,
                                color: boje[data['mood'] - 1],
                              ),
                            ),
                            Expanded(flex: 3, child: Text(data['notes']))
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
