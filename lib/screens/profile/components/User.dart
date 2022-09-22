class User {
  int? id;
  String? email;
  String? password;
  String? repeatPassword;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  Null? accountId;

  User(
      {this.id,
      this.email,
      this.password,
      this.repeatPassword,
      this.firstName,
      this.lastName,
      this.age,
      this.gender,
      this.accountId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    repeatPassword = json['RepeatPassword'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    gender = json['gender'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['RepeatPassword'] = this.repeatPassword;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['accountId'] = this.accountId;
    return data;
  }
}
