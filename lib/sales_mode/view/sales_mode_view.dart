import 'package:flutter/material.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../inventory/viewmodel/product_model.dart';

import '../../shared/views/product_card.dart';

class SalesMode extends StatefulWidget {
  const SalesMode({super.key});

  @override
  State<StatefulWidget> createState() => _SalesMode();
}

class _SalesMode extends State<SalesMode> {
  List<String> stringList = [
    'eCwTkMVjJg',
    'dXkLnPqRzSdRqu',
    'pJlAqSfZwS',
    'iJqKfNcTtTm',
    'nTtLzWtGgJlK',
    'zPvHjEaWcBhLkGm',
    'dRfMjKzSgHfBq',
    'cQdPqZyVxUjKlI',
    'vDqWnZcRrJfK',
    'aRbDpWfVjK',
    'lMnKdHgWtVjQxP',
    'eVzUwGdHcXyN',
    'gPfJlKbWmVzQ',
    'oTnJfCzLxNqGmI',
    'yVqKdPnBfRjMx',
    'mHgRcLdWjP',
    'sFhGjKtRnDm',
    'xSbJkDqHvT',
    'uJfXzPnGtY',
    'tWjKfZpNcR'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: stringList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      // products.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(LabelNames
                            .SALES_MODE_REMOVE_PRODUCT_SCAFFOLD_MESSAGE),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ProductCardView(
                      isSaleMode: true,
                      product: Product(
                          productBarcode: '12345678901',
                          imageUrl: 'https://via.placeholder.com/150',
                          numOfProducts: 23,
                          productCategory: 'it',
                          productName: stringList[index],
                          productPrice: 1234.23)));
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 70,
          decoration:
              BoxDecoration(color: Colors.white24, border: Border.all()),
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: const [
              Text(
                "${LabelNames.SALES_MODE_TOTAL_PRICE}: \$ ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
            decoration:
                BoxDecoration(color: Colors.white24, border: Border.all()),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    // clear the products

                    // save from the state
                  },
                  color: Colors.redAccent,
                  iconSize: 34,
                  icon: const Icon(Icons.delete_forever_rounded),
                  // style: ButtonStyle(
                  //   backgroundColor:
                  //       MaterialStateProperty.all(Colors.redAccent),
                  // ),
                  // label: const Text(LabelNames.SALES_MODE_CLEAN_BUTTON)
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    // scan

                    // save current state to avoid loss current state when page is changed
                    // String barcodeScanRes =
                    //     await FlutterBarcodeScanner.scanBarcode(
                    //         "#ff6666", "Cancel", true, ScanMode.DEFAULT);

                    // addToCart(barcodeScanRes);
                  },
                  iconSize: 34,
                  icon: const Icon(Icons.barcode_reader),
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all(Colors.white10),
                  // ),
                  // label: const Text(LabelNames.SALES_MODE_SCAN_BUTTON)
                ),
              ],
            ))
      ],
    );
  }

  // void addToCart(String? newProduct) {
  //   setState(() {
  //     products.add(newProduct!);
  //   });
  // }
}
