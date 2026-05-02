import 'package:flutter/material.dart';
import 'package:myfluttertask/account_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// NAME
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              /// EMAIL
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (value.length < 8) {
                    return 'password must be at least 8 characters';
                  }
                  if (value.length > 15) {
                    return 'password cannot excess 10 character ';
                  }
                  final specialcharpattern = RegExp('[!@#&*]');
                  if (!specialcharpattern.hasMatch(value)) {
                    return 'password must contain at least on special character(@#&*!)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              /// PHONE
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 11,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number cannot be empty";
                  }
                  if (value.length != 11) {
                    return "Phone must be 11 digits";
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Phone must contain only numbers";
                  }
                  return null;
                },
              ),
              SizedBox(height: 5),

              /// GENDER
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gender",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile(
                title: Text("Male"),
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() => gender = value);
                },
              ),
              RadioListTile(
                title: Text("Female"),
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() => gender = value);
                },
              ),

              SizedBox(height: 10),

              /// ADDRESS
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Address cannot be empty";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              /// BUTTON
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    /// VALID → GO TO ACCOUNT
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AccountPage(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          gender: gender!,
                          address: addressController.text.trim(),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Go to Account", style: TextStyle(fontSize: 18), selectionColor: Colors.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
