import 'package:rxdart/rxdart.dart';

enum AuthOption {
  LOGIN, REGISTER
}

class AuthBloc {

  BehaviorSubject<AuthOption> _optionController = BehaviorSubject<AuthOption>();

  Stream<AuthOption> get optionStream => _optionController.stream;

  Function(AuthOption) get changeOption => _optionController.sink.add;

  AuthOption get option => _optionController.value;

  void dispose() {
    _optionController?.close();
  }

}
