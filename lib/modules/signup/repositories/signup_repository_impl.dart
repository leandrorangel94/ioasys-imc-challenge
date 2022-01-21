import 'package:imc_challenge/modules/signup/repositories/signup_repository.dart';
import 'package:imc_challenge/shared/models/user_model.dart';
import 'package:imc_challenge/shared/services/app_database.dart';

class SignupRepositoryImpl implements SignupRepository {
  final AppDatabase database;

  SignupRepositoryImpl(this.database);
  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await database.createAccount(
        email: email, password: password, name: name);
    return response;
  }
}
