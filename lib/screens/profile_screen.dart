import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _selectedTab = _SelectedTab.profile;

  void _onTabTapped(int index) {
    final tab = _SelectedTab.values[index];
    if (tab == _SelectedTab.home) {
      Navigator.pushReplacementNamed(context, "/home");
    } else if (tab == _SelectedTab.cart) {
      Navigator.pushReplacementNamed(context, "/cart");
    } else {
      setState(() => _selectedTab = tab);
    }
  }

  Widget _buildOption(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 22, color: Colors.black),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildProfileOptions() {
    final options = [
      {"img": "assets/a.png", "label": "Balance"},
      {"img": "assets/b.png", "label": "Reward"},
      {"img": "assets/c.png", "label": "Invite"},
      {"img": "assets/d.png", "label": "Gift Card"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: options.map((opt) {
          return Column(
            children: [
              Image.asset(opt["img"]!, width: 45, height: 45),
              const SizedBox(height: 6),
              Text(
                opt["label"]!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 26, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Account",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //    Tarjeta de perfil
            Container(
              width: double.infinity,
              color: Colors.pinkAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  SizedBox(height: 6),
                  Text("Yev Yev",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Nueva sección de opciones con imágenes
            _buildProfileOptions(),

            //Opciones en formato limpio
            _buildOption(Icons.person, "My Information"),
            _buildOption(Icons.location_on, "Address"),
            _buildOption(Icons.payment, "Payment"),
            _buildOption(Icons.favorite, "My Wishlist"),
            _buildOption(Icons.coffee, "Cafe Following"),
            _buildOption(Icons.history, "Refund"),
            _buildOption(Icons.lock, "Password"),
            _buildOption(Icons.settings, "Setting"),
            _buildOption(Icons.info_outline, "About Company"),
            _buildOption(Icons.logout, "Sign Out"),
            const SizedBox(height: 20),

            const Text("@2022 Cafi",
                style: TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 20),
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
