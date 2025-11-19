// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String id;
  String name;
  int price;
  int stok;
  String description;
  String? thumbnail;
  String category;
  int productViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.stok,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.productViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"]?.toString() ?? "",
        name: json["name"] ?? "",
        price: json["price"] ?? 0,
        stok: json["stok"] ?? 0,
        description: json["description"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"] ?? "",
        productViews: json["product_views"] ?? 0,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        isFeatured: json["is_featured"] ?? false,
        userId: json["user_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stok": stok,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "product_views": productViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
      };
}
