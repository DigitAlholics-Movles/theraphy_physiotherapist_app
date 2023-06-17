import 'dart:convert';
import 'dart:io';

import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:http/http.dart' as http;

class HttpHelper{

    final String urlBase =
      'https://backendproyectotheraphy-production-5698.up.railway.app/api/v1';

    Future<List<Patient>?> getPatients() async {
        const String endpoint = '/patients'; // Ruta del endpoint específico
        final String url = '$urlBase$endpoint'; // URL completo

        http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == HttpStatus.ok) {
          final jsonResponse = json.decode(response.body);
          final List patientsMap = jsonResponse['content'];
          final List<Patient> patients =
              patientsMap.map((map) => Patient.fromJson(map)).toList();
          return patients;
        } else {
          return null;
        }
      }

    Future<List<Appointment>?> getAppointments() async {
        const String endpoint = '/appointments'; // Ruta del endpoint específico
        final String url = '$urlBase$endpoint'; // URL completo

        http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == HttpStatus.ok) {
          final jsonResponse = json.decode(response.body);
          final List appointmentsMap = jsonResponse['content'];
          final List<Appointment> appointments =
              appointmentsMap.map((map) => Appointment.fromJson(map)).toList();
          return appointments;
        } else {
          return null;
        }
      }

}