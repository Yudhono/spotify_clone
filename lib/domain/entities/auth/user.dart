class UserEntity {
  String? userId;
  String? fullName;
  String? email;

  UserEntity({this.userId, this.fullName, this.email});

  UserEntity.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['email'] = email;
    return data;
  }
}
