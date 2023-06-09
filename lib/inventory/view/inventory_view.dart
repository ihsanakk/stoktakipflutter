import 'package:flutter/material.dart';
import 'package:stoktakip/core/cache_manager.dart';
import '../../shared/configuration/dio_options.dart';
import '../../shared/enumLabel/label_names_enum.dart';
import '../../shared/views/product_card.dart';
import '../service/inventory_service.dart';
import '../viewmodel/product_model.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key, required this.gotoProductPage});

  final void Function(Product product) gotoProductPage;

  @override
  State<StatefulWidget> createState() => _InventoryState();
}

class _InventoryState extends State<InventoryView> with CacheManager {
  final List<Product> products = [];

  List<Product> foundproducts = [];
  late final InventoryService inventoryService;

  @override
  void initState() {
    super.initState();
    inventoryService = InventoryService(CustomDio.getDio());
    // getUserProducts();
    loadFromCache();
    foundproducts = products;
  }

  void loadFromCache() async {
    final productList = await getProductsFromCache();
    if (productList != null && productList.isNotEmpty) {
      setState(() {
        products.addAll(productList);
      });
    } else {
      getUserProducts(); // else fetch from server and save to cache
    }
  }

  void getUserProducts() async {
    var response = await inventoryService.getAllUserProducts();
    if (response != null) {
      setState(() {
        products.addAll(response.map((e) {
          return Product.fromModel(e);
        }).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: LabelNames.INVENTORY_VIEW_SEARCH_HINT,
                icon: const Icon(Icons.search_rounded)),
            onChanged: (value) {
              _filter(value);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: foundproducts.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ProductCardView(
                    isSaleMode: false, product: foundproducts[index]),
                onTap: () {
                  widget.gotoProductPage(foundproducts[index]);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 3)
      ],
    );
  }

  void _filter(String value) {
    List<Product> filtered = [];
    if (value.isEmpty) {
      filtered = products;
    } else {
      filtered = products
          .where((element) =>
              element.productName!
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.productBarcode!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      foundproducts = filtered;
    });
  }
}
