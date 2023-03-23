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

  void setLoginDate(int timestamp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(CacheManagerKey.logindate.toString(), timestamp);
  }

  Future<int?> getLoginDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(CacheManagerKey.logindate.toString());
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

  Future<void> setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(CacheManagerKey.theme.toString(), value);
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(CacheManagerKey.theme.toString()) ?? false;
  }
}

enum CacheManagerKey { token, mail, products, cart, logindate, theme }
