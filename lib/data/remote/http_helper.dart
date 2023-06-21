import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';


class HttpHelper {
  final String urlBase = 'https://backendproyectotheraphy-production-41c2.up.railway.app/api/v1/physiotherapists';
  
  Future<List<Physiotherapist>?> getPhysiotherapist() async {
    http.Response response = await http.get(Uri.parse(urlBase));

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
  http.Response response = await http.get(Uri.parse('$urlBase/$physiotherapistId'));

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

  
  
}