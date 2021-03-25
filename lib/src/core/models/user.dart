import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String username;
  final String email;
  final String image;
  final DocumentReference reference;

 User.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['username'] != null),
       assert(map['email'] != null),
       assert(map['image'] != null),
       username = map['username'],
       email = map['email'],
       image = map['image'];

 User.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data(), reference: snapshot.reference);

}