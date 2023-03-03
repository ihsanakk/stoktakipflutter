import 'package:flutter/material.dart';

import '../../shared/enumLabel/label_names_enum.dart';
import '../../shared/views/product_card.dart';
import '../viewmodel/product_model.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key, required this.gotoProductPage});

  final void Function(Product product) gotoProductPage;

  @override
  State<StatefulWidget> createState() => _InventoryState();
}

class _InventoryState extends State<InventoryView> {
  final List<Product> products = [
    Product(productBarcode: "72582394273", productName: "Potato"),
    Product(productBarcode: "3654641418410521469", productName: "Tomato"),
    Product(productBarcode: "546415154", productName: "Onion"),
    Product(productBarcode: "7841549784", productName: "Eggplant"),
    Product(productBarcode: "65665118150", productName: "Terracota"),
    Product(productBarcode: "365512154510", productName: "Something"),
    Product(productBarcode: "9898989787415", productName: "Potato-X"),
    Product(productBarcode: "8878787810214545", productName: "Potato-XL"),
  ];

  List<Product> foundproducts = [];

  @override
  void initState() {
    super.initState();
    foundproducts = products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: const InputDecoration(
                hintText: LabelNames.INVENTORY_VIEW_SEARCH_HINT,
                icon: Icon(Icons.search_rounded)),
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
