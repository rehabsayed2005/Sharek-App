import 'package:flutter/material.dart';
// import 'package:myfluttertask/signup.dart';
// import 'package:myfluttertask/check_out_page.dart';
class AccountPage extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String address;
  const AccountPage({
    super.key,
    required this.email,
    required this.address,
    required this.gender,
    required this.name,
    required this.phone,
  });
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<String> addresses = [];
  TextEditingController newaddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    nameController.text = widget.name;
    phoneController.text = widget.phone;
    _selectGender = widget.gender;
    addressController.text = widget.address;
    addresses.add(widget.address);
  }

  bool isEditing = false;
  String? _selectGender = 'Male';
  void deleteAccount() {
    setState(() {
      emailController.clear();
      nameController.clear();
      phoneController.clear();
      _selectGender = "";
    });
  }

  void confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Account"),
          content: Text("Are you sure you want to delete your account?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                deleteAccount();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 26, color: Colors.black),
          onPressed: () {
                         Navigator.pop(context);
          },
        ),
        title: const Text(
          "Account info",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: isEditing ? Colors.green : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: Text(isEditing ? "Save" : "Edit"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: RadioGroup<String>(
          groupValue: _selectGender,
          onChanged: (value) {
            setState(() {
              _selectGender = value;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: emailController,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              TextField(
                controller: nameController,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: phoneController,
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'PhoneNumber',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 20),

              const Text(
                "Gender",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              RadioListTile<String>(title: Text('Male'), value: 'Male'),
              RadioListTile<String>(title: Text('Female'), value: 'Female'),
              const SizedBox(height: 25),
              // ➕ Add New Address Button
              // ---------- عنوان واحد فقط للكتابة ----------
              TextField(
                controller: newaddressController,
                decoration: InputDecoration(
                  labelText: "Add address",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10),

              // ---------- زرار الإضافة ----------
              GestureDetector(
                onTap: () {
                  if (newaddressController.text.trim().isNotEmpty) {
                    setState(() {
                      addresses.add(newaddressController.text.trim());
                      newaddressController.clear(); // امسح بعد الاضافة
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("Add new address"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ---------- عرض العناوين في قائمة ----------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saved Addresses:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  ...addresses.map((address) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(address),
                    );
                  }).toList(),
                ],
              ),

              //==========================
              Row(
                children: [
                  Padding(padding: EdgeInsetsGeometry.all(20)),
                  //Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: (
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Changes Saved Successfully!"),
                            backgroundColor: Colors.teal,
                          ),
                        );
                        setState(() {
                          isEditing = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Delete Button
                  Center(
                    child: ElevatedButton(
                      onPressed: confirmDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Delete Account",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
