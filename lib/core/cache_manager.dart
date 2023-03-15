import 'package:shared_preferences/shared_preferences.dart';

import '../inventory/viewmodel/product_model.dart';

class CacheManager {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.token.toString(), token);
    return true;
  }

  Future<bool> saveUserMail(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.mail.toString(), mail);
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.token.toString());
  }

  Future<String?> getMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.mail.toString());
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CacheManagerKey.token.toString());
  }

  void saveProductsToCache(List<Product> productList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Product.encode(productList);
    prefs.setString(CacheManagerKey.products.toString(), encodedData);
  }

  Future<List<Product>?> getProductsFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(CacheManagerKey.products.toString()) == null) {
      return null;
    } else {
      String? productsString =
          prefs.getString(CacheManagerKey.products.toString());
      final List<Product> productList = Product.decode(productsString!);
      return productList;
    }
  }

  void saveCartToCache(List<Product> productList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Product.encode(productList);
    prefs.setString(CacheManagerKey.cart.toString(), encodedData);
  }

  Future<List<Product>?> getCartFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(CacheManagerKey.cart.toString()) == null) {
      return null;
    } else {
      String? productsString = prefs.getString(CacheManagerKey.cart.toString());
      final List<Product> productList = Product.decode(productsString!);
      return productList;
    }
  }

  Future<void> clearCartFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CacheManagerKey.cart.toString());
  }

  Future<void> clearProductsFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CacheManagerKey.products.toString());
  }
}

enum CacheManagerKey { token, mail, products, cart }
