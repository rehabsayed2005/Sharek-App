import 'package:flutter/material.dart';
import 'order_summary.dart';

class CheckoutPage extends StatefulWidget {
  final String address; // العنوان اللي جاي من الـ account page

  const CheckoutPage({super.key, required this.address});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "cash";
  String shippingMethod = "fast";
  int shippingPrice = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          textAlign: TextAlign.center,
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Delivery Address ----------------
            _buildSectionBox(
              icon: Icons.location_on,
              title: "Delivery Address",
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  widget.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Payment Method ----------------
            _buildSectionBox(
              icon: Icons.payment,
              title: "Payment Method",
              child: Column(
                children: [
                  RadioListTile(
                    activeColor: Colors.teal,
                    title: const Text("Cash On Delivery"),
                    value: "cash",
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() => paymentMethod = value.toString());
                    },
                  ),
                  RadioListTile(
                    activeColor: Colors.teal,
                    title: const Text("Visa / MasterCard"),
                    value: "visa",
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() => paymentMethod = value.toString());
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- SHIPPING SPEED BOX ----------------
            _buildSectionBox(
              icon: Icons.local_shipping,
              title: "Shipping Speed",
              child: Column(
                children: [
                  RadioListTile(
                    activeColor: Colors.teal,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Fast Delivery (1-2 days)"),
                        Text(
                          "50 EGP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    value: "fast",
                    groupValue: shippingMethod,
                    onChanged: (value) {
                      setState(() {
                        shippingMethod = value.toString();
                        shippingPrice = 50;
                      });
                    },
                  ),

                  RadioListTile(
                    activeColor: Colors.teal,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Standard Delivery (5-7 days)"),
                        Text(
                          "20 EGP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    value: "normal",
                    groupValue: shippingMethod,
                    onChanged: (value) {
                      setState(() {
                        shippingMethod = value.toString();
                        shippingPrice = 20;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ---------------- Confirm order button ----------------
            Center(
              child: SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryPage(
                          address: widget.address,
                          paymentMethod: paymentMethod,
                          shippingMethod: shippingMethod,
                          shippingPrice: shippingPrice,
                          cartItems: [], 
                          productPrice: 3000, 
                          sellerFee: 0.14, 
                          totalPrice: 20000,

                          // price: productPrice,  ← لسه Comment زي ما طلبتي
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---------------- REUSABLE SECTION BOX ----------------
  Widget _buildSectionBox({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          child,
        ],
      ),
    );
  }
}
