class Product {
  final String id;
  final String title;
  final String category_id;
  final int price;
  final String condition;
  final String thumbnail;

  Product(
      {this.id,
      this.title,
      this.category_id,
      this.price,
      this.condition,
      this.thumbnail
      });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        category_id: json['category_id'],
        price: json['price'],
        condition: json['condition'],
        thumbnail: json['thumbnail']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category_id": category_id,
        "price": price,
        "condition": condition,
        "thumbnail": thumbnail
      };
}
