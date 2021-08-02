class Profile {
  String name;
  String email;
  String password;
  String phone;
  String idUser;
  Map<String, dynamic> socialInformation;
  String imageUrl;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'email': email,
      'socialInformation': socialInformation
    };
  }
}
