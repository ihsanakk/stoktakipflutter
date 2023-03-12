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
}
