import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';
import 'package:theraphy_physiotherapist_app/data/model/treatment.dart';

import '../model/patient.dart';


class HttpHelper {
  final String urlBase = 'https://backendproyectotheraphy-production-41c2.up.railway.app/api/v1';
  
  Future<List<Physiotherapist>?> getPhysiotherapist() async {
    const String endpoint = '/physiotherapists';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> physiotherapistMap = jsonResponse['content'];
      final List<Physiotherapist> physiotherapists = physiotherapistMap.map((map) => Physiotherapist.fromJson(map)).toList();
      return physiotherapists;
    } else {
      return null;
    }
  }

  /*Future<List<Physiotherapist>?> getPhysiotherapistById(int physiotherapistId) async {
    http.Response response = await http.get(Uri.parse(urlBase + physiotherapistId.toString()));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> physiotherapistsMap = jsonResponse[''];
      final List<Physiotherapist> pysiotherapists = physiotherapistsMap.map((e) => Physiotherapist.fromJson(e)).toList();
      return pysiotherapists;
    } else {
      return null;
    }     
  }*/

Future<Physiotherapist?> getPhysiotherapistById(int physiotherapistId) async {
  const String endpoint = '/physiotherapists';
  final String url = '$urlBase$endpoint/$physiotherapistId';

  http.Response response = await http.get(Uri.parse(url));

  //http.Response response = await http.get(Uri.parse('$urlBase/$physiotherapistId'));

  if (response.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(response.body);
    final Physiotherapist physiotherapist = Physiotherapist.fromJson(jsonResponse);
    /*final Map<String, dynamic> physiotherapistMap = jsonResponse['physiotherapist'];
    final Physiotherapist physiotherapist = Physiotherapist.fromJson(physiotherapistMap);*/
    return physiotherapist;
  } else {
    return null;
  }
}

Future<List<Patient>?> getPatients() async {
    const String endpoint = '/patients';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));
  
    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> patientMap = jsonResponse['content'];
      final List<Patient> patients = patientMap.map((map) => Patient.fromJson(map)).toList();
      return patients;
    } else {
      return null;
    }
}

Future<List<Appointment>?> getAppointments() async {
    const String endpoint = '/appointments';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> appointmentsMap = jsonResponse['content'];
      final List<Appointment> appointments = appointmentsMap.map((map) => Appointment.fromJson(map)).toList();
      return appointments;
    } else {
      return null;
    }
}

Future<List<Treatment>?> getTreatments() async {
    const String endpoint = '/treatments';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> treatmentsMap = jsonResponse['content'];
      final List<Treatment> treatments = treatmentsMap.map((map) => Treatment.fromJson(map)).toList();
      return treatments;
    } else {
      return null;
    }
}

  

}