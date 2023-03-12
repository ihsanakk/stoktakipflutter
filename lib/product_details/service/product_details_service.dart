import 'package:dio/dio.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/shared/configuration/dio_options.dart';

import '../../shared/enumLabel/label_names_enum.dart';
import '../model/abstract_response.dart';
import '../model/message_response.dart';
import '../model/product_model.dart';
import '../model/unauthorized_response.dart';

// TODO: add interceptor, base client etc. refactor configuration, don't forget login and register.
abstract class IProductDetailsService {
  final String path = '/api/inventory';
  final Dio dio;
  const IProductDetailsService(this.dio);

  Future<AbstractResponse?> getproductByBarcode(String barcode);
  Future<AbstractResponse?> deleteProductByBarcode(String barcode);
  Future<AbstractResponse?> saveProduct(ProductModel productModel);
}

class ProductDetailsService extends IProductDetailsService with CacheManager {
  ProductDetailsService(Dio dio) : super(dio);

  @override
  Future<AbstractResponse?> getproductByBarcode(String barcode) async {
    try {
      final token = await getToken();
      final response = await dio.get("$path/product/$barcode",
          options: CustomDio.authOptions(token));
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        return MessageResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        return UnauthorizedResponse.fromJson(response.data);
      } else {
        print(response.statusCode);
        print(response.requestOptions);
        print(response.data);
        return MessageResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
          if (e.response!.statusCode == 401) {
            return UnauthorizedResponse.fromJson(e.response!.data);
          } else if (e.response!.statusCode == 400) {
            return MessageResponse.fromJson(e.response!.data);
          }
        } else {
          print(e.requestOptions);
          print(e.message);
          return MessageResponse(LabelNames.SERVICE_ERROR);
        }
      }
    }
    return null;
  }

  @override
  Future<AbstractResponse?> deleteProductByBarcode(String barcode) async {
    try {
      final token = await getToken();
      var response = await dio.delete("$path/product/$barcode",
          options: CustomDio.authOptions(token));
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        return MessageResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        return UnauthorizedResponse.fromJson(response.data);
      } else if (response.statusCode == 404) {
        return UnauthorizedResponse.fromJson(response.data);
      } else {
        print(response.statusCode);
        print(response.requestOptions);
        print(response.data);
        return MessageResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
          if (e.response!.statusCode == 401) {
            return UnauthorizedResponse.fromJson(e.response!.data);
          } else if (e.response!.statusCode == 400) {
            return MessageResponse.fromJson(e.response!.data);
          }
        } else {
          print(e.requestOptions);
          print(e.message);
          return MessageResponse(LabelNames.SERVICE_ERROR);
        }
      }
    }
    return null;
  }

  @override
  Future<AbstractResponse?> saveProduct(ProductModel productModel) async {
    try {
      final token = await getToken();
      final response = await dio.post("$path/save",
          data: productModel, options: CustomDio.authOptions(token));
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        return MessageResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        return UnauthorizedResponse.fromJson(response.data);
      } else {
        print(response.statusCode);
        print(response.requestOptions);
        print(response.data);
        return MessageResponse.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
          if (e.response!.statusCode == 401) {
            return UnauthorizedResponse.fromJson(e.response!.data);
          } else if (e.response!.statusCode == 400) {
            return MessageResponse.fromJson(e.response!.data);
          }
        } else {
          print(e.requestOptions);
          print(e.message);
          return MessageResponse(LabelNames.SERVICE_ERROR);
        }
      }
    }
    return null;
  }
}
