class Patient{
    int id;
    int userId;
    String firstName;
    String lastName;
    int age;
    String birthdayDate;
    String email;
    int appointmentQuantity;
    String photoUrl;

  Patient({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.birthdayDate,
    required this.email,
    required this.appointmentQuantity,
    required this.photoUrl
  });
  
   Patient.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userId: json['userId'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            age: json['age'],
            birthdayDate: json['birthdayDate'],
            email: json['email'],
            appointmentQuantity: json['appointmentQuantity'],
            photoUrl: json['photoUrl']
            );

}