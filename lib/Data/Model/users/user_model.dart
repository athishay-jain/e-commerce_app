class UserModel {
  String name;
  String mobileNumber;
  String email;
  String password;
  String? profileImage;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.mobileNumber,
    this.profileImage,
  });

  Map<String, String> toMap() {
    return {
      "name": name,
      "mobile_number": mobileNumber,
      "email": email,
      "password": password,
    };
  }
}
