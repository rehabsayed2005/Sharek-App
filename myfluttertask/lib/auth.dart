import 'package:flutter/material.dart';
class Auth extends StatefulWidget{
  @override
  Authstate createState () => Authstate();
}
class Authstate extends State<Auth>{
    // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
    final _passController = TextEditingController();
    

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:ListView(
        children: [
                    SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration
            (border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passController,
            decoration: InputDecoration
            (border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ) ,
    );

  }
  
}