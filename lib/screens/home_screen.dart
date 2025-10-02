import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedTab = _SelectedTab.home;

  void _onTabTapped(int index) {
    final tab = _SelectedTab.values[index];
    if (tab == _SelectedTab.cart) {
      Navigator.pushReplacementNamed(context, "/cart");
    } else if (tab == _SelectedTab.profile) {
      Navigator.pushReplacementNamed(context, "/profile");
    } else {
      setState(() {
        _selectedTab = tab;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            color: Colors.pinkAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/profile-pic.png"),
                      radius: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Welcome", style: TextStyle(color: Colors.white)),
                        Text("Mr. Yev Yev",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white, size: 28),
                    const SizedBox(width: 16),
                    Stack(
                      children: [
                        const Icon(Icons.notifications,
                            color: Colors.white, size: 28),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "6",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                "Coffee",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushNamed(context, "/product",
                            arguments: product);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Stack(
                              children: [
                                Hero(
                                  tag: "product-img-${product.name}",
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        product.isFavorite =
                                            !product.isFavorite;
                                      });
                                    },
                                    child: Icon(
                                      product.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: product.isFavorite
                                          ? Colors.pink
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Price",
                                          style: TextStyle(fontSize: 16)),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${product.oldPrice.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              decoration: TextDecoration
                                                  .lineThrough,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "\$${product.price.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (i) {
                                        double starValue = product.stars - i;
                                        if (starValue >= 1) {
                                          return const Icon(Icons.star,
                                              color: Colors.amber, size: 16);
                                        } else if (starValue > 0) {
                                          return const Icon(Icons.star_half,
                                              color: Colors.amber, size: 16);
                                        } else {
                                          return const Icon(Icons.star_border,
                                              color: Colors.grey, size: 16);
                                        }
                                      }),
                                      const SizedBox(width: 6),
                                      Text("${product.rating} rating",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.pinkAccent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      onTap: _onTabTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

enum _SelectedTab { home, orders, chat, cart, profile }
