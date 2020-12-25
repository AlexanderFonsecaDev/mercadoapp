import 'package:mercadoapp/model/Category.dart';
import 'dart:convert';

class Catalog{

  final List<Category> categories;

  Catalog({this.categories});

  factory Catalog.fromRawJson(String str) =>
      Catalog.fromJson(json.decode(str)); // 2

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
      categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "categoriesList": List<dynamic>.from(categories.map((x) => x.toJson())),
  };

}