import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthOption {
  LOGIN, REGISTER
}

class AuthBloc {

  BehaviorSubject<AuthOption> _optionController = BehaviorSubject<AuthOption>();

  Stream<AuthOption> get optionStream => _optionController.stream;

  Function(AuthOption) get changeOption => _optionController.sink.add;

  AuthOption get option => _optionController.value;

  Future<DocumentReference> createUser({String username, String email, String password}) async {
    try {
      final reference = await FirebaseFirestore.instance.collection('user').add({
        "username": username,
        "email": email,
        "password": password,
      });
      return reference;
    } catch (error) {
      throw new Exception(error);
    }
  }

  void dispose() {
    _optionController?.close();
  }

}
