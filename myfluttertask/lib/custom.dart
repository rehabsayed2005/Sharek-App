
import 'package:flutter/material.dart';
import 'package:myfluttertask/cartpage.dart';
import 'cartdata.dart';
import 'homepage.dart';
import 'Profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final String userEmail;
  final bool showBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.userName = '',
    this.userEmail = '',
    this.showBack = false, required List<Map<String, dynamic>> cartItems,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 63, 173, 228),
              Color.fromARGB(255, 23, 176, 176),
              Color(0xFF008080),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(name: userName, email: userEmail),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountPage(
                  email: '',
                   address: '',
                    gender: '', 
                    name: '',
                     phone: '',
                  // ممكن تعدلي البيانات هنا لو محتاجه
                ),
              ),
            );
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage(cartItems: [],)),
                );
              },
            ),
            if (CartData.items.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    CartData.items.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}