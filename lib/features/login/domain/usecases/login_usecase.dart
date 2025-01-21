import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> execute(String email, String password) {
    return repository.login(email, password);
  }
}
