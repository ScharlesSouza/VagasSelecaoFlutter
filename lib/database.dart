import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  late FirebaseFirestore firestore;
  initialiase() {
    firestore = FirebaseFirestore.instance;
  }
}
