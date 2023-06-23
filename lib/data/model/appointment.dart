import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';

class Appointment {
  int id;
  Patient patient;
  Physiotherapist physiotherapist;
  String scheduledDate;
  String topic;
  String done;
  String diagnosis;

  Appointment(
      {required this.id,
      required this.patient,
      required this.physiotherapist,
      required this.scheduledDate,
      required this.topic,
      required this.done,
      required this.diagnosis});

  Appointment.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            patient: Patient.fromJson(json['patient']),
            physiotherapist: Physiotherapist.fromJson(json['physiotherapist']),
            scheduledDate: json['scheduledDate'],
            topic: json['topic'],
            done: json['done'],
            diagnosis: json['diagnosis']);
}
