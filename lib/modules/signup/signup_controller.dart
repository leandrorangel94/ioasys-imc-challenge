import 'package:flutter/cupertino.dart';
import 'package:imc_challenge/modules/signup/repositories/signup_repository.dart';
import 'package:imc_challenge/shared/models/user_model.dart';
import 'package:imc_challenge/shared/utils/app_state.dart';

class SignupController extends ChangeNotifier {
  final SignupRepository repository;
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';

  SignupController(this.repository);

  void onChange({String? email, String? password, String? nome}) {
    _email = email ?? _email;
    _password = password ?? _password;
    _name = nome ?? _name;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response = await repository.createAccount(
            email: _email, password: _password, name: _name);
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(AppState.error(
          e.toString(),
        ));
      }
    }
  }
}
