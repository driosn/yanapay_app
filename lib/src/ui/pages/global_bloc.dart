import 'package:rxdart/subjects.dart';
import 'package:yanapay_app/src/core/models/user.dart';

class GlobalBloc {

  static final _singleton = GlobalBloc._internal();

  GlobalBloc._internal();

  factory GlobalBloc() => _singleton;

  BehaviorSubject<User> _userController = BehaviorSubject<User>();

  Stream<User> get userStream => _userController.stream;

  Function(User) get changeUser => _userController.sink.add;

  User get user => _userController.value;

  void dispose() {
    _userController?.close();
  }

}

GlobalBloc globalBloc = GlobalBloc();