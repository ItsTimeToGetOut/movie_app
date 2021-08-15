import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseStorage _store = FirebaseStorage.instance;

Future loginAttempt(var email, var password) async {
  final User user = (await _auth.signInWithEmailAndPassword(
          email: '$email', password: '$password'))
      .user;
  return query();
}

Future registrationAttempt(var email, var password) async {
  final User user = (await _auth.createUserWithEmailAndPassword(
    email: '$email',
    password: '$password',
  ))
      .user;

  initialiseDb();

  return user;
}

Future uploadImage(var image) async {
  var file = File(image.path);
  var snapshot = await _store.ref().child(file.path).putFile(file);
  var downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

initialiseDb() async {
  var databasesPath = await getDatabasesPath();
  String path = databasesPath + '/my_db.db';
  Database db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE movie (id INTEGER PRIMARY KEY, name TEXT, director TEXT, num TEXT');
  });
}

query() async {
  var db = await openDatabase('my_db.db');
  var bro = await db.rawQuery('SELECT * from movie');
  return bro;
}

addMovie(name, director, num) async {
  var db = await openDatabase('my_db.db');
  await db.execute('INSERT INTO movie(name, director, num) VALUES(?, ?, ?)',
      [name, director, num]);
}

deleteMovie(id) async {
  var db = await openDatabase('my_db.db');
  await db.execute('DELETE FROM movie WHERE id=\"$id\"');
}
