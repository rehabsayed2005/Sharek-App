import 'package:flutter/material.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double price = 1000;
    double commission = price * 0.05;
    double totalEarnings = price - commission;

    return Scaffold(
      backgroundColor: Color(0xffF5F7FA),
      appBar: AppBar(
        title: Text("Earnings"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTile("Product Price", price.toString()),
            buildTile("Commission (5%)", commission.toStringAsFixed(2)),
            buildTile("Your Earnings", totalEarnings.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Widget buildTile(String title, String value) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value, style: TextStyle(color: Colors.teal, fontSize: 16)),
        ],
      ),
    );
  }
}