import 'package:flutter/material.dart';
import 'order_summary.dart';

class PaymentPage extends StatefulWidget {
  final String address;
  final String paymentMethod;
  final String shippingMethod;
  final int shippingPrice;
  final double productPrice;
  final double sellerFee;
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const PaymentPage({
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
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _paymentMethod = 'Debit Card';

  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool get isCardPayment =>
      _paymentMethod == 'Debit Card' || _paymentMethod == 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // إزالة لون الخلفية الافتراضي ليظهر التدرج
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Online Payment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // إضافة التدرج اللوني هنا
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 63, 173, 228), // اللون الأول
                Color.fromARGB(255, 23, 176, 176), // اللون الثاني
                Color(0xFF008080),                 // اللون الثالث
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            RadioListTile(
              title: const Text('Debit Card'),
              value: 'Debit Card',
              groupValue: _paymentMethod,
              onChanged: (v) => setState(() => _paymentMethod = v!),
            ),
            RadioListTile(
              title: const Text('Cash When Receive'),
              value: 'Cash When Receive',
              groupValue: _paymentMethod,
              onChanged: (v) => setState(() => _paymentMethod = v!),
            ),
            RadioListTile(
              title: const Text('Credit Card'),
              value: 'Credit Card',
              groupValue: _paymentMethod,
              onChanged: (v) => setState(() => _paymentMethod = v!),
            ),
            const SizedBox(height: 20),
            if (isCardPayment)
              Column(
                children: [
                  TextField(
                    controller: _cardHolderController,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: 'CVV *',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text("Products: ${widget.productPrice.toStringAsFixed(2)} EGP"),
                  Text("Commission: ${widget.sellerFee.toStringAsFixed(2)} EGP"),
                  Text("Shipping: ${widget.shippingPrice} EGP"),
                  const Divider(),
                  Text(
                    "Total: ${widget.totalPrice.toStringAsFixed(2)} EGP",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                if (isCardPayment &&
                    (_cardHolderController.text.isEmpty ||
                        _cvvController.text.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please fill Card Holder Name and CVV'),
                    ),
                  );
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderSummaryPage(
                      address: widget.address,
                      paymentMethod: widget.paymentMethod,
                      shippingMethod: widget.shippingMethod,
                      shippingPrice: widget.shippingPrice,
                      productPrice: widget.productPrice,
                      sellerFee: widget.sellerFee,
                      totalPrice: widget.totalPrice,
                      cartItems: widget.cartItems,
                    ),
                  ),
                );
              },
              child: Text(
                _paymentMethod == 'Cash When Receive'
                    ? 'Confirm Order'
                    : 'Pay Now',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}