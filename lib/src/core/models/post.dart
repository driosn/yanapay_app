import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  final String description;
  final String email;
  final String username;
  final String userImage;
  final String image;
  final DocumentReference reference;

 Post.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['description'] != null),
       assert(map['email'] != null),
       assert(map['username'] != null),
       assert(map['userImage'] != null),
       assert(map['image'] != null),
       description = map['description'],
       email = map['email'],
       username = map['username'],
       userImage = map['userImage'],
       image = map['image'];

 Post.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data(), reference: snapshot.reference);

}