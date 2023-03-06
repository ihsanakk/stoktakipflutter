import 'package:flutter/material.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';

import '../enumLabel/label_names_enum.dart';

class ProductDetails extends StatefulWidget {
  final Product? product;
  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_NAME,
                  ),
                  initialValue: widget.product!.productName ?? '',
                  onChanged: (value) {
                    setState(() {
                      // TODO:
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      // TODO:
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      // TODO:
                    });
                  },
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_QUANTITY,
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '${widget.product!.numOfProducts ?? ''}',
                  onChanged: (value) {
                    setState(() {
                      // TODO:
                    });
                  },
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
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_DESCRIPTION,
            ),
            initialValue: widget.product!.productName ?? '',
            onChanged: (value) {
              setState(() {
                // TODO:
              });
            },
          ),
        ],
      ),
    );
  }
}
