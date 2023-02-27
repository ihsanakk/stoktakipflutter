import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../shared/views/product_details_shared.dart';

class ProductView extends StatefulWidget {
  Product? product;

  ProductView({Key? key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  Product productPlaceholder = Product(
      imageUrl: '',
      numOfProducts: 0,
      productCategory: '',
      productName: '',
      productPrice: 0.0);

  @override
  Widget build(BuildContext context) {
    // scanProductBarcode();

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductDetails(product: widget.product ?? productPlaceholder),
          const SizedBox(
            height: 16,
          ),
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
