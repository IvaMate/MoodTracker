class Moods {
  int mood = 1;
  DateTime time = DateTime.now();
  String notes = '';
  String action = '';
}

class Osoba {
  String id = '';
  String ime = '';
  String prezime = '';
  String email = '';
  List<Moods> moods = [];
}
