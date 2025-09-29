class Product {
  final String name;
  final String image;
  final double oldPrice;
  final double price;
  final int rating;
  final bool isFavorite;

  Product({
    required this.name,
    required this.image,
    required this.oldPrice,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}


final List<Product> products = [
  Product(
    name: "Mocha Frappe",
    image: "assets/mocha_frappe.png",
    oldPrice: 5.50,
    price: 3.50,
    rating: 152,
    isFavorite: true,
  ),
  Product(
    name: "Ice Green Tea",
    image: "assets/ice_green_tea.png",
    oldPrice: 2.50,
    price: 1.50,
    rating: 302,
  ),
  Product(
    name: "Hot Expresso",
    image: "assets/hot_expresso.png",
    oldPrice: 3.20,
    price: 2.20,
    rating: 92,
  ),
  Product(
    name: "Amakado Hot",
    image: "assets/amakado_hot.png",
    oldPrice: 3.50,
    price: 2.50,
    rating: 34,
    isFavorite: true,
  ),
];
