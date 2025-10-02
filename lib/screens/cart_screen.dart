import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _selectedTab = _SelectedTab.cart;

  double get subtotal => products
      .where((p) => p.inCart)
      .fold(0, (sum, p) => sum + (p.price * p.cartCount));

  void _onTabTapped(int index) {
    final tab = _SelectedTab.values[index];
    if (tab == _SelectedTab.home) {
      Navigator.pushReplacementNamed(context, "/home");
    } else if (tab == _SelectedTab.profile) {
      Navigator.pushReplacementNamed(context, "/profile");
    } else {
      setState(() => _selectedTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vat = subtotal * 0.07;
    final total = subtotal + vat;
    final cartItems = products.where((p) => p.inCart).toList();

    return Scaffold(
      backgroundColor: Colors.white, // fondo blanco puro
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 26, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Edit",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
      body: Column(
        children: [
          //Lista de productos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, i) {
                final p = cartItems[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // gris muy claro
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            p.image,
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.name,
                                  style: const TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                              const SizedBox(height: 4),
                              Text("${p.price}\$",
                                  style: const TextStyle(
                                      fontSize: 22)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (p.cartCount > 1) {
                                    p.cartCount--;
                                  } else {
                                    p.inCart = false;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.pinkAccent, size: 28),
                            ),
                            Text("${p.cartCount}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  p.cartCount++;
                                });
                              },
                              icon: const Icon(Icons.add_circle,
                                  color: Colors.pinkAccent, size: 28),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Order Summary",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sub total", style: TextStyle(fontSize: 20)),
                    Text("${subtotal.toStringAsFixed(2)}\$",
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("VAT", style: TextStyle(fontSize: 18)),
                    Text("${vat.toStringAsFixed(2)}\$",
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),

                // Campo de cupón
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Coupon Here",
                          hintStyle:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {},
                      child: const Text("Apply",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Text("${total.toStringAsFixed(2)}\$",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onPressed: () {},
                    child: const Text("Place Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ],
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
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
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
