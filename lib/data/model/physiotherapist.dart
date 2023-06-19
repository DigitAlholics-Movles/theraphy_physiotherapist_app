class Physiotherapist {
  int id;
  String firstName;
  String paternalSurname;
  String maternalSurname;
  int age;
  int rating;
  String location;
  String photoUrl;
  String birthdayDate;
  int consultationsQuantity;
  String specialization;
  String email;
  int userId;


  Physiotherapist(
      {required this.id,
      required this.firstName,
      required this.paternalSurname,
      required this.maternalSurname,
      required this.age,
      required this.rating,
      required this.location,
      required this.photoUrl,
      required this.birthdayDate,
      required this.consultationsQuantity,
      required this.specialization,
      required this.email,
      required this.userId,
      });

  Physiotherapist.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          firstName: json['firstName'],
          paternalSurname: json['paternalSurname'],
          maternalSurname: json['maternalSurname'],
          age: json['age'],
          rating: json['rating'],
          location: json['location'],
          photoUrl: json['photoUrl'],
          birthdayDate: json['birthdayDate'],
          consultationsQuantity: json['consultationsQuantity'],
          specialization: json ['specialization'],
          email: json['email'],
          userId: json['userId']
        );
  
}