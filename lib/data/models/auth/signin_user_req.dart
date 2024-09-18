class SigninUserReq {
  final String email;
  final String password;

  SigninUserReq({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  SigninUserReq copyWith({
    String? email,
    String? password,
  }) {
    return SigninUserReq(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
