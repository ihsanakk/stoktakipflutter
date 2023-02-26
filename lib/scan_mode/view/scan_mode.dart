import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../shared/views/product_details_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  Product product = Product(
      imageUrl: 'xx',
      numOfProducts: 12,
      productCategory: 'Category',
      productName: 'Product Name',
      productPrice: 50.25);

  @override
  Widget build(BuildContext context) {
    // scanProductBarcode();

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductDetailsView(product: product),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text(LabelNames.PRODUCT_VIEW_SCAN)),
          )
        ],
      ),
    );
  }

  void scanProductBarcode() async {
    String result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);

    setState(() {});
  }
}