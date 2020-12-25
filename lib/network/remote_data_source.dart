import 'dart:async';

import 'package:mercadoapp/model/Catalog.dart';
import 'package:mercadoapp/model/Product.dart';
import 'package:mercadoapp/model/Stock.dart';
import 'package:mercadoapp/network/category_client.dart';
import 'package:mercadoapp/network/product_category_client.dart';
import 'package:http/http.dart';
import '../model/Result.dart';
import '../util/request_type.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse = RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  CategoryClient client = CategoryClient(Client());
  ProductCategoryClient product_category_client = ProductCategoryClient(Client());

  Future<Result> getCategories() async {
    try {
      final response = await client.request(requestType: RequestType.GET, path: "sites/MCO");
      if (response.statusCode == 200) {
        return Result<Catalog>.success(Catalog.fromRawJson(response.body));
      } else {
        return Result.error("Categories list not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }

  Future<Result> getProducts(String category_id) async {
    try {
      final response = await product_category_client.request(requestType: RequestType.GET, path: "sites/MCO/search?category=" + category_id);
      if (response.statusCode == 200) {
        return Result<Stock>.success(Stock.fromRawJson(response.body));
      } else {
        return Result.error("Products list not available");
      }
    } catch (error) {
      print(error);
      return Result.error("Something went wrong!");
    }
  }




}
