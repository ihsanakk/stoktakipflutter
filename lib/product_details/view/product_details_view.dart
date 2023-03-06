import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

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
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: Placeholder(),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_NAME,
                        ),
                        initialValue: widget.product!.productName ?? '',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_BARCODE,
                        ),
                        initialValue: widget.product!.productBarcode ?? '',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_PRICE,
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: '${widget.product!.productPrice ?? ''}',
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText:
                              LabelNames.PRODUCT_DETAILS_PRODUCT_QUANTITY,
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: '${widget.product!.numOfProducts ?? ''}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_CREATED_AT,
                  ),
                  initialValue: widget.product!.productName ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_DESCRIPTION,
                  ),
                  initialValue: widget.product!.productName ?? '',
                ),
              ],
            ),
          ),
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
