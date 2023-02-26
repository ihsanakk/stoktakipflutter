import 'package:flutter/material.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../inventory/view/product_card.dart';
import '../../inventory/viewmodel/product_model.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SalesMode extends StatefulWidget {
  const SalesMode({super.key});

  @override
  State<StatefulWidget> createState() => _SalesMode();
}

class _SalesMode extends State<SalesMode> {
  // load from the state if !null
  // final List<String> products = const [];
  // List<Map<String, dynamic>> products = [
  //   {
  //     'name': 'Product 1',
  //     'quantity': 1,
  //     'barcode': '1234567890',
  //   },
  //   {
  //     'name': 'Product 2',
  //     'quantity': 2,
  //     'barcode': '2345678901',
  //   },
  //   {
  //     'name': 'Product 3',
  //     'quantity': 1,
  //     'barcode': '3456789012',
  //   },
  // ];

  // void incrementQuantity(int index) {
  //   setState(() {
  //     products[index]['quantity']++;
  //   });
  // }

  // void decrementQuantity(int index) {
  //   setState(() {
  //     if (products[index]['quantity'] > 1) {
  //       products[index]['quantity']--;
  //     } else {
  //       products.removeAt(index);
  //     }
  //   });
  // }

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
                        content: Text(' removed from cart'),
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
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://via.placeholder.com/150'),
                            ),
                          ),
                        ),
                        visualDensity:
                            const VisualDensity(vertical: 3), // to expand
                        title: Text(stringList[index], maxLines: 2),
                        subtitle: const Text("Spec"),
                        trailing: Column(
                          children: [
                            Text(
                              stringList[index].toUpperCase(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                                const SizedBox(width: 3),
                                const Text("1")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
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
