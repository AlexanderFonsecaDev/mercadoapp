import 'package:mercadoapp/model/Category.dart';
import 'dart:convert';

import 'package:mercadoapp/model/Product.dart';

class Stock{

  final List<Product> products;

  Stock({this.products});

  factory Stock.fromRawJson(String str) =>
      Stock.fromJson(json.decode(str)); // 2

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
      products: List<Product>.from(
          json["results"].map((x) => Product.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "productsList": List<dynamic>.from(products.map((x) => x.toJson())),
  };

}