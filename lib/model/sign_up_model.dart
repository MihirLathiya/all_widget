class SignUpModel {
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? avatar;

  SignUpModel(
      {this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.avatar});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    password = json['password'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['password'] = password;
    data['avatar'] = avatar;
    return data;
  }
}
