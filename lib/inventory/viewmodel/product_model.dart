import 'dart:convert';

import '../model/product_model.dart';

class Product {
  String? imageUrl;
  String? productName;
  String? productCategory;
  int? numOfProducts;
  double? productPrice;
  String? productBarcode;

  Product(
      {this.imageUrl,
      this.productBarcode,
      this.productName,
      this.productCategory,
      this.numOfProducts,
      this.productPrice});

  Product.fromModel(ProductModel productModel) {
    productBarcode = productModel.productBarcode;
    productName = productModel.productName;
    numOfProducts = productModel.numOfProducts;
    productPrice = productModel.productPrice;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productBarcode: json["productBarcode"],
      productName: json["productName"],
      productCategory: json["productCategory"],
      numOfProducts: json["numOfProducts"],
      productPrice: json["productPrice"]?.toDouble(),
    );
  }

  static Map<String, dynamic> toMap(Product product) => {
        'productBarcode': product.productBarcode,
        'productName': product.productName,
        'numOfProducts': product.numOfProducts,
        'productPrice': product.productPrice,
      };

  static String encode(List<Product> products) => json.encode(
        products
            .map<Map<String, dynamic>>((music) => Product.toMap(music))
            .toList(),
      );
  static List<Product> decode(String products) =>
      (json.decode(products) as List<dynamic>)
          .map<Product>((item) => Product.fromJson(item))
          .toList();
}
