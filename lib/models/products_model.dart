import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/models/categories_model.dart';

class ProductModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  // String? creationAt;
  // String? updatedAt;
  CategoriesModel? category;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.images,
      // this.creationAt,
      // this.updatedAt,
      this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    // creationAt = json['creationAt'];
    // updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? new CategoriesModel.fromJson(json['category'])
        : null;
  }
  static List<ProductModel> productsFromSnapshot(List productSnapshot) {
    return productSnapshot.map((data) {
      // print("data ${productSnapshot[0]}: ");
      return ProductModel.fromJson(data);
    }).toList();
  }
}
