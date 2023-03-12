import 'package:dio/dio.dart';

import '../../core/cache_manager.dart';
import '../../shared/configuration/dio_options.dart';
import '../model/product_model.dart';

abstract class IinventoryService {
  final String path = '/api/inventory';
  final Dio dio;

  const IinventoryService(this.dio);

  Future<List<ProductModel>?> getAllUserProducts();
}

class InventoryService extends IinventoryService with CacheManager {
  const InventoryService(Dio dio) : super(dio);

  @override
  Future<List<ProductModel>?> getAllUserProducts() async {
    try {
      final token = await getToken();
      var response =
          await dio.get("$path/all", options: CustomDio.authOptions(token));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((p) => ProductModel.fromJson(p))
            .toList();
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print(e.response!.data);
          print(e.response!.headers);
          print(e.response!.requestOptions);
          if (e.response!.statusCode == 401) {
          } else if (e.response!.statusCode == 400) {}
        } else {
          print(e.requestOptions);
          print(e.message);
        }
      }
    }
    return null;
  }
}
