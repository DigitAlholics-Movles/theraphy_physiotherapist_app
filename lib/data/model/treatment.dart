class Treatment{
  int id;
  String title;
  String description;
  int sessionsQuantity;
  int physiotherapistId;
  String photoUrl;

  Treatment({
    required this.id,
    required this.title,
    required this.description,
    required this.sessionsQuantity,
    required this.physiotherapistId,
    required this.photoUrl
  });

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sessionsQuantity': sessionsQuantity,
      'physiotherapist': physiotherapistId,
      'photoUrl': photoUrl,
    };
  }

  Treatment.fromJson(Map<String, dynamic> json)
    : this(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      sessionsQuantity: json['sessionsQuantity'],
      physiotherapistId: json['physiotherapistId'] ?? 0, // Corregir la clave a 'physiotherapistId'
      photoUrl: json['photoUrl']
    );

}
