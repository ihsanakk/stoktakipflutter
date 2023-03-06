import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/shared/configuration/dio_options.dart';

import '../model/product_model.dart';

abstract class IProductDetailsService {
  final String path = '/api/inventory';
  final Dio dio;
  const IProductDetailsService(this.dio);

  Future<ProductModel?> getproductByBarcode(String barcode);
  Future<ProductModel?> deleteProductByBarcode(String barcode);
  Future<ProductModel?> saveProduct(ProductModel productModel);
}

class ProductDetailsService extends IProductDetailsService with CacheManager {
  ProductDetailsService(Dio dio) : super(dio);

  @override
  Future<ProductModel?> getproductByBarcode(String barcode) async {
    try {
      final token = await getToken();
      final response = await dio.get("$path/product/$barcode",
          options: CustomDio.authOptions(token));
      if (response.statusCode == HttpStatus.ok) {
        return ProductModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode == 401) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }

  @override
  Future<ProductModel?> deleteProductByBarcode(String barcode) async {
    try {
      final token = await getToken();
      final response = await dio.delete("$path/product/$barcode",
          options: CustomDio.authOptions(token));
      if (response.statusCode == HttpStatus.ok) {
        return ProductModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode == 401) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }

  @override
  Future<ProductModel?> saveProduct(ProductModel productModel) async {
    try {
      final token = await getToken();
      final response = await dio.post("$path/save",
          data: productModel, options: CustomDio.authOptions(token));
      if (response.statusCode == HttpStatus.ok) {
        return ProductModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        if (e.response!.statusCode == 401) {}
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }
}
