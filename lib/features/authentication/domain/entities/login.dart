class UserLoginInfo {
  final String? token;
  final String name;
  final String email;
  final String userId;
  const UserLoginInfo({
    this.token,
    required this.name,
    required this.email,
    required this.userId,
  });

  @override
  String toString() {
    return 'UserLoginInfo(token: $token, name: $name, email: $email, userId: $userId)';
  }
}
