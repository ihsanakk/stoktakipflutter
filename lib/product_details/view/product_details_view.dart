import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../shared/views/product_details_shared.dart';

class ProductView extends StatefulWidget {
  final Product? product;

  const ProductView({Key? key, this.product}) : super(key: key);

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

  bool _isScanned = false;

  @override
  void initState() {
    super.initState();
    _isScanned = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductDetails(
              product: (_isScanned
                  ? (productPlaceholder)
                  : (widget.product ?? productPlaceholder))),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // TODO:
                },
                icon: const Icon(
                  Icons.delete,
                  size: 36,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(width: 16.0),
              IconButton(
                onPressed: () {
                  // TODO:
                },
                icon: const Icon(
                  Icons.file_upload_rounded,
                  size: 36,
                  color: Colors.greenAccent,
                ),
              ),
            ],
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

    setState(() {
      _isScanned = true;
    });
  }
}
