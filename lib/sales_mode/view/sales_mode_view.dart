import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';
import 'package:collection/collection.dart';
import '../../inventory/viewmodel/product_model.dart';

import '../../shared/views/product_card.dart';

class SalesMode extends StatefulWidget {
  const SalesMode({super.key, required this.gotoProductPage});

  final void Function(Product product) gotoProductPage;

  @override
  State<StatefulWidget> createState() => _SalesMode();
}

class _SalesMode extends State<SalesMode> with CacheManager {
  final List<Product> cart = [];
  List<Product>? cacheProducts;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCartFormCache();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    _removeProductFromCart(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(LabelNames
                            .SALES_MODE_REMOVE_PRODUCT_SCAFFOLD_MESSAGE),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      widget.gotoProductPage(cart[index]);
                    },
                    child:
                        ProductCardView(isSaleMode: true, product: cart[index]),
                  ));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.black26,
          height: 70,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "${LabelNames.SALES_MODE_TOTAL_PRICE}: \$ ",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
            color: Colors.black26,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _clearCart();
                    clearCartFromCache();
                  },
                  color: Colors.redAccent,
                  iconSize: 34,
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _addToCart();
                  },
                  iconSize: 34,
                  icon: const Icon(Icons.barcode_reader),
                ),
              ],
            ))
      ],
    );
  }

  void showMessage(String? message) {
    if (message != '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  _removeProductFromCart(index) {
    setState(() {
      cart.removeAt(index);
      saveCartToCache(cart);
    });
  }

  _loadCartFormCache() async {
    var cacheCart = await getCartFromCache();
    if (cacheCart != null && cacheCart.isNotEmpty) {
      setState(() {
        cart.addAll(cacheCart);
      });
    }
  }

  _loadProducts() async {
    final products = await getProductsFromCache();
    if (products != null && products.isNotEmpty) {
      cacheProducts = products;
    }
  }

  _addToCart() async {
    var result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    try {
      Product? foundProduct = cacheProducts
          ?.firstWhereOrNull((element) => element.productBarcode == result);
      if (foundProduct != null) {
        setState(() {
          cart.add(foundProduct);
          saveCartToCache(cart);
        });
      } else {
        showMessage(LabelNames.SALES_MODE_YOU_NOT_HAVE_THE_PRODUCT);
      }
    } catch (e) {
      print(e);
    }
  }

  _clearCart() {
    setState(() {
      cart.clear();
    });
  }
}
