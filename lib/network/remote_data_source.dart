import 'dart:async';

import 'package:mercadoapp/model/Catalog.dart';
import 'package:mercadoapp/network/category_client.dart';
import 'package:http/http.dart';
import '../model/Result.dart';
import '../util/request_type.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse = RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  CategoryClient client = CategoryClient(Client());

  Future<Result> getCategories() async {
    try {
      final response = await client.request(requestType: RequestType.GET, path: "MCO");
      if (response.statusCode == 200) {
        return Result<Catalog>.success(Catalog.fromRawJson(response.body));
      } else {
        return Result.error("Categories list not available");
      }
    } catch (error) {
      return Result.error("Something went wrong!");
    }
  }
}
