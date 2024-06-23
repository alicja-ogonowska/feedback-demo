class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}
