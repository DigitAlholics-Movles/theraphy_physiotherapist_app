class Physiotherapist {
  int id;
  String firstName;
  String paternalSurname;
  String maternalSurname;
  String specialization;
  int age;
  String location;
  String photoUrl;
  String birthdayDate;
  int consultationsQuantity;
  String email;
  double rating;
  int userId;


  Physiotherapist(
      {required this.id,
      required this.firstName,
      required this.paternalSurname,
      required this.maternalSurname,
      required this.specialization,
      required this.age,
      required this.location,
      required this.photoUrl,
      required this.birthdayDate,
      required this.consultationsQuantity,  
      required this.email,
      required this.rating,
      required this.userId,
      });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'paternalSurname': paternalSurname,
      'maternalSurname': maternalSurname,
      'specialization': specialization,
      'age': age,
      'location': location,
      'photoUrl': photoUrl,
      'birthdayDate': birthdayDate,
      'consultationsQuantity': consultationsQuantity,
      'email': email,
      'rating': rating,
      'userId': userId,
    };
  }

  Physiotherapist.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          firstName: json['firstName'],
          paternalSurname: json['paternalSurname'],
          maternalSurname: json['maternalSurname'],
          specialization: json ['specialization'],
          age: json['age'],     
          location: json['location'],
          photoUrl: json['photoUrl'],
          birthdayDate: json['birthdayDate'],
          consultationsQuantity: json['consultationsQuantity'],
          email: json['email'],
          rating: json['rating'],
          userId: json['userId']
        );
  
}
