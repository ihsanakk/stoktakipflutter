import 'package:flutter/material.dart';
import 'package:stoktakip/inventory/view/product_card.dart';

import '../viewmodel/product_model.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  final List<String> products = const ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ProductCard(
                    product: Product(
                        imageUrl: 'https://via.placeholder.com/150',
                        numOfProducts: 23,
                        productCategory: 'it',
                        productName: products[index],
                        productPrice: 1234.23)),
                onTap: () {
                  print("clicked");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
