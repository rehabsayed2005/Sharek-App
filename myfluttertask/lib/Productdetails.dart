import 'package:flutter/material.dart';
import 'cartpage.dart';
import 'custom.dart';
import 'cartdata.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  String selectedSize = 'S';
  int selectedColorIndex = 0;

  final List<String> sizes = ['S', 'M', 'L'];

  final List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void addToCart() {
    final String category =
        widget.product['category']?.toString().toLowerCase() ?? '';

    final item = {
      'name': widget.product['name'],
      'price': widget.product['price'],
      'image': widget.product['imageUrl'],
      'quantity': quantity,
    };

    if (category == 'clothes') {
      item['size'] = selectedSize;
    }

    if (category != 'beauty') {
      item['color'] = colors[selectedColorIndex];
    }

    CartData.add(item);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartPage(cartItems: []),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.product['name'] ?? 'Product';
    final String imageUrl = widget.product['imageUrl'] ?? '';
    final String description =
        widget.product['description'] ?? 'No description available';
    final double price = (widget.product['price'] ?? 0).toDouble();
    final String category =
        widget.product['category']?.toString().toLowerCase() ?? '';

    /// ✅ CONDITION FIX
    final String condition =
        widget.product['condition'] == 'New'
            ? 'New'
            : (widget.product['usedType'] ?? 'Used');

    return Scaffold(
      appBar: CustomAppBar(title: name, cartItems: CartData.items),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Category: ${widget.product['category'] ?? 'N/A'}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// ✅ CONDITION يظهر صح
                  Text(
                    "Condition: $condition",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${price.toStringAsFixed(2)} EGP",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (category == 'clothes') ...[
                    const Text("Size"),
                    const SizedBox(height: 10),
                    Row(
                      children: sizes.map((size) {
                        final isSelected = selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  if (category != 'beauty') ...[
                    const Text("Color"),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(colors.length, (index) {
                        final isSelected = selectedColorIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                  ],

                  Row(
                    children: [
                      const Text("Qty"),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: addToCart,
              child: const Text(
                "ADD TO CART",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}