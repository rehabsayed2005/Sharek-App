import 'package:flutter/material.dart';
import './homepage.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          title: const Text("About Us", style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 63, 173, 228),
                  Color.fromARGB(255, 23, 176, 176),
                  Color(0xFF008080),
                ],
              ),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "About Our App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to our marketplace — the trusted place where you can easily buy and sell both new and used products."
                  " Our platform is designed to make online shopping simple, fast, and safe for everyone.\n\n"
                  "Through our app, you can:\n"
                  "• Buy a wide variety of products — whether brand-new or gently used — at great prices.\n"
                  "• Sell your own items with ease and reach thousands of potential buyers.\n"
                  "• Enjoy a smooth and secure experience, as we ensure quality listings and safe transactions.\n"
                  "• Benefit from fair commission rates applied only when your product is successfully sold.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
