class AuthService {
  String? _currentUserName;

  String? get currentUserName => _currentUserName;
  bool get isLoggedIn => _currentUserName != null && _currentUserName!.isNotEmpty;

  bool login(String name) {
    if (name.trim().isEmpty) return false;
    _currentUserName = name.trim();
    return true;
  }

  void logout() {
    _currentUserName = null;
  }
}