class AuthRepository {
  String? _token;

  void saveToken(String token) {
    _token = token;
    print("Token saqlandi: $_token");
  }

  String? get token => _token;

  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  void clearToken() {
    _token = null;
    print("Token o‘chirildi (logout)");
  }
}
