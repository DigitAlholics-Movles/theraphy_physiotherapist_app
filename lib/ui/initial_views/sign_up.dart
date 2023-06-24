import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/ui/initial_views/login.dart';

import '../../data/model/patient.dart';
import '../../data/model/physiotherapist.dart';
import '../../data/model/user.dart';
import '../../data/remote/http_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _selectedRole = 'Patient';
  bool _passwordVisible = false;
  bool _acceptTerms = false;
  String email = "";
  String fullName = "";
  String password = "";

  TextEditingController? _fullnameController;
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

    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    _fullnameController?.dispose();

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

  createUser() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var acceptTerms = _acceptTerms;
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 80),
          height: 200,
          child: Image.asset(
            'assets/background.png',
            width: 450,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, top: 40),
        child: Text(
          "Sign Up",
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
                  setState(() {});
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
                controller: _fullnameController,
                onChanged: (value) {
                  fullName = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'FullName',
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
                  setState(() {});
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
      SizedBox(height: 20),
      Expanded(
        flex: 3,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: SizedBox(
                      height:
                          54, // Establecer la misma altura que los TextField
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
                          ),
                          value: _selectedRole,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedRole = newValue!;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: <String>['Patient', 'Physiotherapist']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors
                                          .grey[600], // Color menos oscuro
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:
                        -3.5, // Ajustar la posición vertical según tus necesidades
                    left:
                        15, // Ajustar la posición horizontal según tus necesidades
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Rol',
                        style: TextStyle(
                          color: Colors.grey, // Color del texto "Rol"
                          fontSize: 13, // Tamaño del texto "Rol"
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value!;
                        });
                      },
                    ),
                    Text("I accept the terms and conditions"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: ElevatedButton(
                    onPressed: _acceptTerms &&
                            email != "" &&
                            fullName != "" &&
                            password != ""
                        ? () {
                            bool registered = false;

                            for (int i = 0; i < users!.length; i++) {
                              if (users![i].email == email) registered = true;
                            }

                            if (registered) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                        'You are already registered on Theraphy'),
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
                            } else {
                              if (email.contains("@") &&
                                  email.contains(".") &&
                                  fullName.split(" ").length > 2 &&
                                  fullName[fullName.length - 1] != " ") {
                                httpHelper?.createUser(users!.length + 1, email,
                                    password, _selectedRole.toLowerCase());

                                if (_selectedRole.toLowerCase() == "patient") {
                                  String firstName = "";
                                  String lastname = "";
                                  for (int i = 0;
                                      i < fullName.split(" ").length;
                                      i++) {
                                    if (i == fullName.split(" ").length - 1) {
                                      lastname += " ${fullName.split(" ")[i]}";
                                    } else if (i ==
                                        fullName.split(" ").length - 2) {
                                      lastname = fullName.split(" ")[i];
                                    } else if (i == 0) {
                                      firstName = fullName.split(" ")[i];
                                    } else {
                                      firstName += " ${fullName.split(" ")[i]}";
                                    }
                                  }

                                  httpHelper?.createPatient(
                                      0,
                                      firstName,
                                      lastname,
                                      18,
                                      "https://static.wikia.nocookie.net/alfondohaysitio/images/c/cc/Jorge_Guerra_%282022%29.png/revision/latest/thumbnail/width/360/height/360?cb=20220825014018&path-prefix=es",
                                      "2000-01-01",
                                      0,
                                      email,
                                      users![users!.length - 1].id + 1);
                                } else {
                                  String firstName = "";
                                  String paternalSurname = "";
                                  String maternalSurname = "";
                                  for (int i = 0;
                                      i < fullName.split(" ").length;
                                      i++) {
                                    if (i == fullName.split(" ").length - 1) {
                                      maternalSurname = fullName.split(" ")[i];
                                    } else if (i ==
                                        fullName.split(" ").length - 2) {
                                      paternalSurname = fullName.split(" ")[i];
                                    } else if (i == 0) {
                                      firstName = fullName.split(" ")[i];
                                    } else {
                                      firstName += " ${fullName.split(" ")[i]}";
                                    }
                                  }
                                  httpHelper?.createPhysiotherapist(
                                      0,
                                      firstName,
                                      paternalSurname,
                                      maternalSurname,
                                      "Ginecologo-Urologo",
                                      18,
                                      "Lima",
                                      "https://pbs.twimg.com/media/EX1XRQGXgAArHrq.jpg",
                                      "1980-01-01",
                                      0,
                                      email,
                                      5,
                                      users![users!.length - 1].id + 1);
                                }

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //////////////////
                                      //MARIAAAA AQUI PONES EL HOMEEEEEEE
                                      //////////////
                                      builder: (context) => const Login(),
                                    ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                          'You have introduced an incorrect email or incomplete name'),
                                      actions: [
                                        TextButton(
                                          child: Text('Try Again'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }

                            // Acción a realizar al presionar el botón
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: _acceptTerms &&
                              email != "" &&
                              fullName != "" &&
                              password != ""
                          ? Colors.blue[700]
                          : Colors.grey, // Color de fondo
                      onPrimary: Colors.white, // Color del texto
                      padding: EdgeInsets.symmetric(
                          vertical: 20), // Padding vertical del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Join Us Before?"),
                    GestureDetector(
                      onTap: () {
                        getData("userId");
                        Navigator.pop(context);
                        // Manejar el evento cuando se presiona "Log In"
                        // Aquí puedes agregar la lógica para navegar a la pantalla de inicio de sesión
                      },
                      child: Text(
                        " Log In",
                        style: TextStyle(
                          fontWeight: FontWeight
                              .bold, // Aplicar negrita al texto "Log In"
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
