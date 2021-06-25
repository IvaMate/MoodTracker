import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/osoba.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

class Database {
  static Stream<QuerySnapshot> getUsers() {
    return users.snapshots();
  }

  static Stream<QuerySnapshot> getUserMoods(String id) {
    return users.doc(id).collection('moods').snapshots();
  }

  static Future<bool> addMood(String id, Moods m) async {
    Map<String, dynamic> data = {
      'mood': m.mood,
      'notes': m.notes,
      //'action': m.action,
      'time': Timestamp.fromDate(DateTime.now()),
    };

    await users.doc(id).collection('moods').add(data).whenComplete(() => true);

    return false;
  }

  static Future<bool> addUser(Osoba o) async {
    Map<String, dynamic> data = {
      'ime': o.ime,
      'prezime': o.prezime,
      'email': o.email,
    };

    await users
        .doc(o.id)
        .set(data)
        .whenComplete(() => true)
        .onError((error, stackTrace) {
      print(error);
      return false;
    });

    return false;
  }
}
