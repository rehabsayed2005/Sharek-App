import 'package:flutter/material.dart';
import 'package:myfluttertask/Productdetails.dart';
import 'package:myfluttertask/Profile_page.dart';

import 'shop.dart';
import './cartpage.dart';
import 'about_us_page.dart';
// import 'authscreen.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String address;

  const HomePage({
    super.key,
    this.email = '',
    this.name = '',
    this.phone = '',
    this.gender = '',
    this.address = '',
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> recommendedProducts = [];


  final List<Map<String, String>> categories = [
    {'name': 'Electronics', 'image': 'assets/images/WhatsApp Image (2).jpeg'},
    {'name': 'Clothes', 'image': 'assets/images/WhatsApp fashion Image .jpeg'},
    {'name': 'Beauty', 'image': 'assets/images/WhatsApp Image .jpeg'},
    {
      'name': 'Accessories',
      'image': 'assets/images/WhatsApp accessories Image.jpeg'
    },
  ];

  @override
  void initState() {
    super.initState();
  }


  Widget _buildCategoryItem(
      BuildContext context, Map<String, String> category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShopPage(
              category: category['name']!,
              cartItems: cartItems,
              onAddToCart: () {},
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(category['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            category['name']!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sharek',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 63, 173, 228),
                Color.fromARGB(255, 23, 176, 176),
                Color(0xFF008080),
              ],
            ),
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: Colors.teal),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.teal),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AccountPage(
                        email: '',
                        address: '',
                          gender: '', 
                          name: '', 
                          phone: '',
                        )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sell, color: Colors.teal),
              title: const Text('Seller'),
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.teal),
              title: const Text('About'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.teal),
              title: const Text('Logout'),
            ),
            
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "What are you looking for:",
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
                children: categories
                    .map((c) => _buildCategoryItem(context, c))
                    .toList(),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Recommended for you",
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recommendedProducts.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = recommendedProducts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetails(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      product['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(8),
                            child: Text(
                              product['name'],
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets
                                .symmetric(horizontal: 8),
                            child: Text(
                              "${product['price']} EGP",
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AccountPage(
                    email: '', 
                    address: '',
                  gender: '',
                      name: '', 
                      phone: '',
                      )
                      ),
            );
          } else if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CartPage(cartItems: cartItems),
              ),
            );
          } else {
            setState(() => currentIndex = i);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Account"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
    );
  }
}