import 'package:flutter/material.dart';
import 'custom.dart';
import 'Productdetails.dart';

class ShopPage extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> cartItems;

  const ShopPage({
    super.key,
    required this.category,
    required this.cartItems,
    required Null Function() onAddToCart,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  List<Map<String, dynamic>> allProducts = [];
  bool isLoading = true;

  String searchQuery = "";
  String selectedTab = "All";
  String selectedCondition = "All";

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> tabs =
        widget.category == "Beauty" ? ["All"] : ["All", "New", "Used"];

    List<String> conditions = ["All", "Like New", "Almost New", "Good"];

    /// ✅ فلترة المنتجات
    final filteredProducts = allProducts
        .where((p) => p['category'] == widget.category)
        .where((p) {
          if (selectedTab == "All") return true;
          return p['type'] == selectedTab;
        })
        .where((p) {
          if (selectedTab == "Used" && selectedCondition != "All") {
            return p['condition'] == selectedCondition;
          }
          return true;
        })
        .where((p) {
          if (searchQuery.isEmpty) return true;
          return p['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        })
        .toList();

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: CustomAppBar(
        title: widget.category,
        cartItems: widget.cartItems,
        showBack: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  /// 🔍 Search
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search products",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) => setState(() => searchQuery = v),
                    ),
                  ),

                  /// 🟦 Tabs
                  if (tabs.length > 1)
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        itemBuilder: (_, i) {
                          final tab = tabs[i];
                          final selected = selectedTab == tab;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = tab;
                                selectedCondition = "All";
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.blue
                                    : Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tab,
                                style: TextStyle(
                                  color:
                                      selected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  /// 🟩 Conditions
                  if (selectedTab == "Used")
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: conditions.length,
                        itemBuilder: (_, i) {
                          final cond = conditions[i];
                          final selected = selectedCondition == cond;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedCondition = cond),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.teal
                                    : Colors.teal.shade100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                cond,
                                style: TextStyle(
                                  color:
                                      selected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  /// 🛒 Products Grid
                  GridView.builder(
                    padding: const EdgeInsets.all(12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (_, i) {
                      final product = filteredProducts[i];
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
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  product['name'], // تم التأكد من أنه يقرأ 'productName' من الـ Map
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                child: Text(
                                  "EGP ${product['price']}",
                                  style: TextStyle(
                                    color: Colors.teal.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}