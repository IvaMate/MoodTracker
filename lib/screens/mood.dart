import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/osoba.dart';
import 'package:myapp/services/database.dart';

class Mood extends StatefulWidget {
  const Mood({Key? key}) : super(key: key);

  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  var moodKey = GlobalKey<FormState>();
  Moods mood = Moods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: moodKey,
            child: Column(
              children: [
                new Text('Trenutno raspoloženje:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.mood = 1;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.deepPurple,
                        size: 50.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.mood = 2;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.mood = 3;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.yellow,
                        size: 50.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.mood = 4;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.orange,
                        size: 50.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.mood = 5;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.red,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Text('Bilješka: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Upiši bilješku'),
                      maxLines: 5,
                      onSaved: (value) {
                        setState(() {
                          mood.notes = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text('Aktivnosti: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
/*
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.action = 1;
                        });
                      },
                      icon: Icon(
                      Icons.emoji_food_beverage,
                      color: Colors.green,
                      size: 50.0,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.action = 2;
                        });
                      },
                      icon: Icon(
                      Icons.chrome_reader_mode,
                      color: Colors.green,
                      size: 50.0,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.action = 3;
                        });
                      },
                      icon: Icon(
                      Icons.run_circle,
                      color: Colors.green,
                      size: 50.0,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.action = 4;
                        });
                      },
                      icon: Icon(
                      Icons.local_dining_sharp,
                      color: Colors.green,
                      size: 50.0,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          mood.action = 5;
                        });
                      },
                      icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.green,
                      size: 50.0,
                      ),
                    ),
*/

                    Icon(
                      Icons.emoji_food_beverage,
                      color: Colors.green,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.chrome_reader_mode,
                      color: Colors.green,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.run_circle,
                      color: Colors.green,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.local_dining_sharp,
                      color: Colors.green,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.shopping_bag,
                      color: Colors.green,
                      size: 50.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 50.0,
                        )),
                    SizedBox(
                      width: 220.0,
                    ),
                    IconButton(
                      onPressed: () async {
                        if (moodKey.currentState!.validate()) {
                          moodKey.currentState!.save();
                          await Database.addMood(
                              FirebaseAuth.instance.currentUser!.uid, mood);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
