import 'package:imc_challenge/shared/models/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login({required String email, required String password});
}
