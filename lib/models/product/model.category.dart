// To parse this JSON data, do
//
//     final productCategoryData = productCategoryDataFromJson(jsonString);

class Category {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? category;
  String? categoryImage;

  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        category: json["category"],
        categoryImage: json["categoryImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category,
        "categoryImage": categoryImage,
      };
}
