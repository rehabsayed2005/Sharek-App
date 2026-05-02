import 'package:flutter/material.dart';
import 'package:myfluttertask/cartdata.dart';
import 'custom.dart';
import 'check_out_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required List<dynamic> cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<Map<String, dynamic>, int> productQuantity = {};

  @override
  void initState() {
    super.initState();
    for (var p in CartData.items) {
      p['quantity'] = p['quantity'] ?? 1;
      productQuantity[p] = p['quantity'];
    }
  }

  void incrementQuantity(Map<String, dynamic> product) {
    setState(() {
      productQuantity[product] = (productQuantity[product] ?? 1) + 1;
      product['quantity'] = productQuantity[product];
    });
  }

  void decrementQuantity(Map<String, dynamic> product) {
    setState(() {
      if ((productQuantity[product] ?? 1) > 1) {
        productQuantity[product] = productQuantity[product]! - 1;
        product['quantity'] = productQuantity[product];
      } else {
        productQuantity.remove(product);
        CartData.remove(product);
      }
    });
  }

  double getTotalPrice() {
    double total = 0;
    for (var product in CartData.items) {
      final price = (product['price'] as num).toDouble();
      final quantity = product['quantity'] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Cart', cartItems: []),
      body: Container(
        color: Colors.white, // ✅ BACKGROUND أبيض
        child: Column(
          children: [
            Expanded(
              child: CartData.items.isEmpty
                  ? const Center(
                      child: Text(
                        "Cart is empty",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: CartData.items.length,
                      itemBuilder: (context, index) {
                        final product = CartData.items[index];
                        final quantity = product['quantity'] ?? 1;
                        final price =
                            (product['price'] as num).toDouble();

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product['image'] ?? '',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image_not_supported),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Unit: $price EGP",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Total: ${(price * quantity).toStringAsFixed(2)} EGP",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Color(0xFF008080),
                                      ),
                                      onPressed: () =>
                                          decrementQuantity(product),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Color(0xFF008080),
                                      ),
                                      onPressed: () =>
                                          incrementQuantity(product),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            /// ✅ Order Summary (White)
            if (CartData.items.isNotEmpty)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "${getTotalPrice().toStringAsFixed(2)} EGP",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutPage(
                                // cartItems: CartData.items,
                                 address: 'assuit',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008080),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}