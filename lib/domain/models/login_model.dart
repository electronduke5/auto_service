class LoginModel {
  String? login;
  String? password;
  String? error;

  LoginModel(this.login, this.password);

  LoginModel.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'login': login,
        'password': password,
      };
}
