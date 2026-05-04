import 'dart:math';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:myfluttertask/cartdata.dart'; 
class OrderSummaryPage extends StatelessWidget {
  final String address;
  final String paymentMethod;
  final String shippingMethod;
  final int shippingPrice;
  final double productPrice;
  final double sellerFee;
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const OrderSummaryPage({
    super.key,
    required this.address,
    required this.paymentMethod,
    required this.shippingMethod,
    required this.shippingPrice,
    required this.productPrice,
    required this.sellerFee,
    required this.totalPrice,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    String arrivalDate = shippingMethod == "fast"
        ? "Arrives in 1-2 days"
        : "Arrives in 5-7 days";

    String paymentText = paymentMethod == "cash"
        ? "Cash On Delivery"
        : "Visa / MasterCard";

    String shippingText = shippingMethod == "fast"
        ? "Fast Delivery (1-2 days)"
        : "Standard Delivery (5-7 days)";

    int orderId = Random().nextInt(999999);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 216, 208),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 26),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Your order has been placed successfully!",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _sectionTitle("Order Details"),
            _buildInfoBox(title: "Order ID", value: "#$orderId"),
            const SizedBox(height: 16),
            _sectionTitle("Shipping"),
            _buildInfoBox(
              title: "Shipping Method",
              value: "$shippingText — $shippingPrice EGP",
            ),
            const SizedBox(height: 16),
            _sectionTitle("Payment"),
            _buildInfoBox(title: "Payment Method", value: paymentText),
            const SizedBox(height: 16),
            _sectionTitle("Delivery"),
            _buildInfoBox(title: "Delivery Address", value: address),
            const SizedBox(height: 16),
            _buildInfoBox(title: "Expected Arrival", value: arrivalDate),
            const SizedBox(height: 22),
            _sectionTitle("Payment Summary"),
            _buildInfoBox(
                title: "Product Price",
                value: "${productPrice.toStringAsFixed(2)} EGP"),
            const SizedBox(height: 12),
            _buildInfoBox(
                title: "Seller Fee (5%)",
                value: "${sellerFee.toStringAsFixed(2)} EGP"),
            const SizedBox(height: 12),
            _buildInfoBox(
                title: "Total Price",
                value: "${totalPrice.toStringAsFixed(2)} EGP"),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 260,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // ✅ تفريغ الكارت بالكامل (تحت + فوق)
                    CartData.items.clear();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.teal),
      ),
    );
  }

  Widget _buildInfoBox({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}