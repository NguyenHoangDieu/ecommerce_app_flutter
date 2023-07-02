class Cart {
  int productId;
  String name;
  double price;
  int count;
  bool isCheck = false;
  String image;
  Cart({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.count,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      productId: json['productId'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      count: json['count'],
    );
  }
}
