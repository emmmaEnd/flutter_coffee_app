class Product {
  final String name;
  final String image;
  final double oldPrice;
  final double price;
  final int rating;
  final double stars;
  bool isFavorite;
  bool inCart;
  int cartCount;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.oldPrice,
    required this.price,
    required this.rating,
    required this.stars,
    this.isFavorite = false,
    this.inCart = false,
    this.cartCount = 0,
    this.description = "Lorem ipsum!!!",
  });
}



final List<Product> products = [
  Product(
    name: "Mocha Frappe",
    image: "assets/mocha_frappe.png",
    oldPrice: 5.50,
    price: 3.50,
    rating: 152,
    stars: 3.5,
    isFavorite: true,
    description: "Fresh mocha frappe xd",
  ),
  Product(
    name: "Ice Green Tea",
    image: "assets/ice_green_tea.png",
    oldPrice: 2.50,
    price: 1.50,
    stars: 4.0,
    rating: 302,
    isFavorite: false,
  ),
  Product(
    name: "Hot Expresso",
    image: "assets/hot_expresso.png",
    oldPrice: 3.20,
    price: 2.20,
    rating: 92,
    stars: 4,
    isFavorite: false,
  ),
  Product(
    name: "Amakado Hot",
    image: "assets/amakado_hot.png",
    oldPrice: 3.50,
    price: 2.50,
    rating: 34,
    stars: 4,
    isFavorite: true,
  ),
];
