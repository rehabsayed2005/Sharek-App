//  note that to run this project you should go to the main.dart and write this code:
// import 'package:flutter/material.dart';
// import 'login.dart';

// main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
//   }
// }
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); //formkey=>name of key
  String? email; //to store value of email
  String? password; //to store value of password
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'login ',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(color: Colors.white, offset: Offset(2, 2), blurRadius: 4),
            ],
          ),
        ),
        elevation: 10,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 14, 168, 220),
                Color.fromARGB(255, 149, 199, 220),
                Color.fromARGB(255, 210, 216, 220),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/image.jpg',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  TextFormField(
                    controller:
                        emailController, //to take text that given by user
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains('@')) {
                        return "Please enter a valid email with this sign @";
                      }
                      if (!value.endsWith(".com")) {
                        return "Email must end with.'.com',please rewrite this email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 23, color: Colors.black),
                      hintText: 'email@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 14, 187, 226),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 187, 226),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(22)),
                  TextFormField(
                    controller:
                        passwordController, //to take text that given by user
                    onSaved: (value) => password = value,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is requred';
                      }
                      if (value.length < 8) {
                        return 'password must be at least 8 characters';
                      }
                      if (value.length > 10) {
                        return 'password cannot excess 10 character ';
                      }
                      final specialcharpattern = RegExp('[!@#&*]');
                      if (!specialcharpattern.hasMatch(value)) {
                        return 'password must contain at least on special character(@#&*!)';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 187, 226),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 14, 187, 226),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Remember me',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        'Forget password',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Center(
                    child: Container(
                      width: double.maxFinite,
                      height: 55,
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: const Color.fromARGB(255, 14, 187, 226),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // formKey.currentState!.save();
                            print('valid');
                          } else {
                            print('not valid');
                          }
                        },
                        child: Text(
                          'login',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
