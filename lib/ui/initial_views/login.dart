//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';
import 'package:theraphy_physiotherapist_app/ui/home/home.dart';

import 'package:theraphy_physiotherapist_app/ui/initial_views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/model/user.dart';

import '../../data/model/physiotherapist.dart';
import '../../data/remote/http_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter_icons/flutter_icons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  bool _errorState = false;

  String email = "";
  String password = "";

  TextEditingController? _usernameController;
  TextEditingController? _passwordController;

  HttpHelper? httpHelper;
  List<Physiotherapist>? physioterapists = [];
  List<Patient>? patients = [];
  List<User>? users = [];

  void saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    //print('Valor guardado en el almacenamiento local.');
  }

  void getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    print('Valor recuperado del almacenamiento local: $value');
  }

  Future initialize() async {
    physioterapists = List.empty();
    physioterapists = await httpHelper?.getPhysiotherapist();

    setState(() {
      physioterapists = physioterapists;
    });

    patients = List.empty();
    patients = await httpHelper?.getPatients();
    setState(() {
      patients = patients;
    });

    users = List.empty();
    users = await httpHelper?.getUsers();
    setState(() {
      users = users;
    });
  }

  @override
  void initState() {
    httpHelper = HttpHelper();

    initialize();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  navigateTo({required Widget widget}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        ((route) => false));
  }

  login() async {}

  getUsername() async {}

  signOut() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ...

    return WillPopScope(
        onWillPop: () async {
          // Bloquear la acción de retroceso
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 80),
                      height: 200,
                      child: Image.asset(
                        'assets/logotheraphy.png',
                        width: 450,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _usernameController,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(400),
                                  width: 2.0, // Grosor del borde
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(400),
                                  width: 2.0, // Grosor del borde
                                ),
                              ),
                              contentPadding: EdgeInsets.all(20),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: !_passwordVisible,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(400),
                                  width: 2.0, // Grosor del borde
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(400),
                                  width: 2.0, // Grosor del borde
                                ),
                              ),
                              contentPadding: EdgeInsets.all(20),
                              isDense: true,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        bool found = false;
                        users?.forEach((element) {
                          if (element.email == email &&
                              element.password == password) {
                            found = true;
                            print(element.id);
                            physioterapists?.forEach((doctor) {
                              if (element.id == doctor.userId) {
                                saveData("userId", doctor.id.toString());
                              }
                            });
                            //getData("userId");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //////////////////
                                  //MARIAAAA AQUI PONES EL HOMEEEEEEE
                                  //////////////
                                  builder: (context) =>
                                      const HomePhysiotherapist(),
                                ));
                          }
                        });
                        if (!found) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content:
                                    Text('Your email or password is incorrect'),
                                actions: [
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        // Acción a realizar al presionar el botón
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[700], // Color de fondo
                        onPrimary: Colors.white, // Color del texto
                        padding: EdgeInsets.symmetric(
                            vertical: 20), // Padding vertical del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 2, // Grosor de las líneas
                            height: 20,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 2, // Grosor de las líneas
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                 const  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción a realizar al presionar el botón
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[700], // Color de fondo
                          onPrimary: Colors.white, // Color del texto
                          padding: const EdgeInsets.symmetric(
                              vertical: 20), // Padding vertical del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:const Text(
                          "Log in with Google",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                        // Acción a realizar al presionar el botón
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "New to Therapy? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Register",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
