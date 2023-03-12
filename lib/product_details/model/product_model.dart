import 'abstract_response.dart';

class ProductModel extends AbstractResponse {
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

  ProductModel.fromJson(Map<String, dynamic> json) {
    productBarcode = json['barcode'];
    productName = json['name'];
    productCategory = json['category'];
    numOfProducts = json['quantity'];
    productPrice = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = productBarcode;
    data['name'] = productName;
    data['category'] = productCategory;
    data['quantity'] = numOfProducts;
    data['price'] = productPrice;
    return data;
  }
}
