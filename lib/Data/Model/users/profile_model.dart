class ProfileDataResponse {
  final bool status;
  final String message;
  final ProfileResponse data;

  ProfileDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      ProfileDataResponse(
        status: json["status"],
        message: json["message"],
        data: ProfileResponse.fromJson(json["data"]),
      );
}

class ProfileResponse {
  final String id;
  final String name;
  final String email;
  final String mobileNumber;
  final String password;
  final String image;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
