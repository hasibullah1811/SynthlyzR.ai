import '../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 2));
    if (email == "test@example.com" && password == "password") {
      return;
    } else {
      throw Exception("Invalid credentials");
    }
  }
}
