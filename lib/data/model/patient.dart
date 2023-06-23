class Patient{
    int id;
    String firstName;
    String lastName;
    int age;
    String photoUrl;
    String birthdayDate;
    int appointmentQuantity;
    String email;
    int userId;
    
    
  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.photoUrl,
    required this.birthdayDate,
    required this.appointmentQuantity,
    required this.email,
    required this.userId
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'photoUrl': photoUrl,
      'birthdayDate': birthdayDate,
      'appointmentQuantity': appointmentQuantity,
      'email': email,
      'userId': userId,
    };
  }

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