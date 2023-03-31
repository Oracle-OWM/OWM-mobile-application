class LoginModel {
  int status;
  String errorNum;
  String message;
  User user;

  LoginModel({this.status, this.errorNum, this.message, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNum = json['errorNum'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String phone;
  String image;
  TokenData tokenData;

  User(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.image,
      this.tokenData});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    tokenData = json['token_data'] != null
        ? TokenData.fromJson(json['token_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    if (tokenData != null) {
      data['token_data'] = tokenData.toJson();
    }
    return data;
  }
}

class TokenData {
  String accessToken;
  String tokenType;
  int expiresIn;

  TokenData({this.accessToken, this.tokenType, this.expiresIn});

  TokenData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }
}
