import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/constands/api_consts.dart';
import 'package:store_api_flutter_course/models/products_model.dart';

class APIHandler {
  static Future<List<ProductModel>> getAllProducts() async {
    // https://api.escuelajs.co/api/v1/products
    var uri = Uri.https(BASE_URL, "api/v1/products");

    var response = await http.get(uri);
    // print("Response: ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("V $v \n\n");
    }
    return ProductModel.productsFromSnapshot(tempList);
  }
}
