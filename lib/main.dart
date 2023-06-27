import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/firebase_options.dart';
import 'package:theraphy_physiotherapist_app/ui/initial_views/login.dart';

void main() async {

  

  //aea

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("userId");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
