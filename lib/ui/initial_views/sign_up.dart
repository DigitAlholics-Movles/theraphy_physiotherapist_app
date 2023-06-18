import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 
  String? _selectedRole = 'Patient';
  bool _passwordVisible = false;
  bool? _acceptTerms = false;

  TextEditingController? _fullnameController;
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;


  @override
  void initState() {
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

  createUser() async {
   
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    onChanged: (value) {},
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
                    onChanged: (value) {},
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
                          height: 54, // Establecer la misma altura que los TextField
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                              ),
                              value: _selectedRole,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedRole = newValue;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              items: <String>['Patient', 'Physiotherapist'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.grey[600], // Color menos oscuro
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
                        top: -3.5, // Ajustar la posición vertical según tus necesidades
                        left: 15, // Ajustar la posición horizontal según tus necesidades
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
                              _acceptTerms = value;
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
                          onPressed: () {
                            // Acción a realizar al presionar el botón
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[700], // Color de fondo
                            onPrimary: Colors.white, // Color del texto
                            padding: EdgeInsets.symmetric(vertical: 20), // Padding vertical del botón
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
                            Navigator.pop(context);
                            // Manejar el evento cuando se presiona "Log In"
                            // Aquí puedes agregar la lógica para navegar a la pantalla de inicio de sesión
                          },
                          child: Text(
                            " Log In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Aplicar negrita al texto "Log In"
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

          
























        ]
      ) 
    );



    /*return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/login.jpg',
                    height: size.height * 0.35,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Username'),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Password'),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: const Icon(Icons.visibility),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Password'),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    createUser();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Sign up'),
                ),
              ),
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Sign in'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              )
            ],
          ),
        ),
      ),
    );*/
  }
}
