import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/ui/initial_views/sign_up.dart';


class Login extends StatefulWidget { 
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
 

  @override
  void initState() {
  
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    getUsername();
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

  login() async {
    
  }

  getUsername() async {
  

  }

  signOut() async {
   
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logotheraphy.png',
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
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    login();
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
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
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
              TextButton(
                onPressed: () {
                  signOut();
                },
                child: const Text('Forgot password?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
