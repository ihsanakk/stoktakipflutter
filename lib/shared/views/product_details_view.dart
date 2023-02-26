import 'package:flutter/material.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';

import '../enumLabel/label_names_enum.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;
  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_NAME,
            ),
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(text: widget.product.productName),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_BARCODE,
            ),
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(text: widget.product.productName),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_CREATED_AT,
            ),
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(text: widget.product.productName),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_DESCRIPTION,
            ),
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(text: widget.product.productName),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_PRICE,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(
                text: widget.product.productName /* toStringAsFixed(2)*/),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_QUANTITY,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
            controller: TextEditingController(text: widget.product.productName),
          ),
          const SizedBox(height: 32.0),
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
        ],
      ),
    );
  }
}
