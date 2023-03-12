import 'dart:convert';

import 'abstract_response.dart';

List<ProductModel> welcomeFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String welcomeToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel extends AbstractRespone {
  String? productName;
  String? productCategory;
  int? numOfProducts;
  double? productPrice;
  String? productBarcode;

  ProductModel(
      {this.productBarcode,
      this.productName,
      this.productCategory,
      this.numOfProducts,
      this.productPrice});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productBarcode: json["barcode"],
        productName: json["name"],
        productCategory: json["category"],
        numOfProducts: json["quantity"],
        productPrice: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "barcode": productBarcode,
        "name": productName,
        "category": productCategory,
        "quantity": numOfProducts,
        "price": productPrice,
      };
}
