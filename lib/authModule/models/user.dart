class User {
  final String? id;
  final String? name;
  final String? imagePath;
  final DateTime? birthDate;
  final String? gender;
  final String? email;
  final String? mobileNumber;
  List wishlistCourseIds;
  List enrolledCourseIds;

  User(
      {this.id,
      required this.name,
      required this.imagePath,
      required this.birthDate,
      required this.gender,
      required this.email,
      required this.mobileNumber,
      required this.wishlistCourseIds,
      required this.enrolledCourseIds});

  static User jsonToUser(Map user) {
    return User(
      id: user['_id'],
      name: user['name'] ?? '',
      imagePath: user['imagePath'] ?? '',
      birthDate: DateTime.parse(user['birthDate']).toLocal(),
      gender: user['gender'] ?? "male",
      email: user['email'] ?? '',
      mobileNumber: user['mobileNumber'] ?? 0,
      wishlistCourseIds: user['wishlistCourseIds'] ?? [],
      enrolledCourseIds: user['enrolledCourseIds'] ?? [],
    );
  }
}
