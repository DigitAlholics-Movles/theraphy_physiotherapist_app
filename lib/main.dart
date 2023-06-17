import 'package:flutter/material.dart';
//import 'package:theraphy_physiotherapist_app/ui/initial_views/login.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/patients_list.dart';

void main() {
  runApp(const MainApp()); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PatientsList()
    );
  }
}
