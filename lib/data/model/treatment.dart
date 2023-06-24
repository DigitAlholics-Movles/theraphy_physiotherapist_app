import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';

class Treatment {
  int id;
  String title;
  String description;
  String photoUrl;
  int sessionsQuantity;
  Physiotherapist physiotherapist;

  Treatment({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
    required this.sessionsQuantity,
    required this.physiotherapist,
  });

  Treatment.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          photoUrl: json['photoUrl'],
          sessionsQuantity: json['sessionsQuantity'],
          physiotherapist: Physiotherapist.fromJson(json['physiotherapist']),
        );
}
