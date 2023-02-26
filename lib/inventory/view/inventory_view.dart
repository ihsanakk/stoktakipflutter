import 'package:flutter/material.dart';
import 'package:stoktakip/shared/views/product_details_shared.dart';

import '../../shared/views/product_card.dart';
import '../viewmodel/product_model.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key, required this.gotoProductPage});

  final void Function(Product product) gotoProductPage;

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
                child: ProductCardView(
                    isSaleMode: false,
                    product: Product(
                        imageUrl: 'https://via.placeholder.com/150',
                        numOfProducts: 23,
                        productCategory: 'it',
                        productName: products[index],
                        productPrice: 1234.23)),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProductDetailsView(
                  //             product: Product(
                  //                 imageUrl: 'https://via.placeholder.com/150',
                  //                 numOfProducts: 23,
                  //                 productCategory: 'it',
                  //                 productName: products[index],
                  //                 productPrice: 1234.23))));
                  print("Clicked");
                  gotoProductPage(Product(
                      imageUrl: 'https://via.placeholder.com/150',
                      numOfProducts: 23,
                      productCategory: 'it',
                      productName: products[index],
                      productPrice: 1234.23));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
