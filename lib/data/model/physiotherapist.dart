class Physiotherapist{
    int id;
    int userId;
    String firstName;
    String paternalSurname;
    String maternalSurname;
    String specialization;
    int age;
    String location;
    String birthdayDate;
    String email;
    double rating;
    int consultationsQuantity;
    String photoUrl;

  Physiotherapist({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.paternalSurname,
    required this.maternalSurname,
    required this.specialization,
    required this.age,
    required this.location,
    required this.birthdayDate,
    required this.email,
    required this.rating,
    required this.consultationsQuantity,
    required this.photoUrl

  });
  
   Physiotherapist.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userId: json['userId'],
            firstName: json['firstName'],
            paternalSurname: json['paternalSurname'],
            maternalSurname: json['maternalSurname'],
            specialization: json['specialization'],
            age: json['age'],
            location: json['location'],
            birthdayDate: json['birthdayDate'],
            email: json['email'],
            rating: json['rating'],
            consultationsQuantity: json['consultationsQuantity'],
            photoUrl: json['photoUrl']
            );

}