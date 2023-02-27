import 'package:flutter/material.dart';

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
                        productBarcode: '12345678901',
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
        FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          onPressed: () {
            gotoProductPage(Product());
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
