import 'package:imc_challenge/shared/models/user_model.dart';

abstract class SignupRepository {
  Future<UserModel> createAccount(
      {required String email, required String password, required String name});
}
