class Patient {
  int id;
  int userId;
  String firstName;
  String lastName;
  int appointmentQuantity;
  String email;
  int age;
  String photoUrl;
  String birthdayDate;

  Patient({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.appointmentQuantity,
    required this.email,
    required this.age,
    required this.photoUrl,
    required this.birthdayDate,
  });

  Patient.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          userId: json['userId'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          appointmentQuantity: json['appointmentQuantity'],
          email: json['email'],
          age: json['age'],
          photoUrl: json['photoUrl'],
          birthdayDate: json['birthdayDate'],
        );
}
