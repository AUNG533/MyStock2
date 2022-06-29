// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
// String JSON to List
List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
// List to JSON string
String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// Constructor
class Product {
  Product({
    required this.id,
    this.name,
    required this.image,
    this.stock,
    this.price,
    this.createdAt,
    this.updatedAt,
  });
  // Variables
  int id;
  String? name;
  String image;
  int? stock;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  // Constructor Object
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    stock: json["stock"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  // Map JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "stock": stock,
    "price": price,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
