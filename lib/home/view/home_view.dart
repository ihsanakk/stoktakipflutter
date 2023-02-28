import 'package:flutter/material.dart';
import 'package:stoktakip/inventory/view/inventory_view.dart';
import 'package:stoktakip/sales_mode/view/sales_mode_view.dart';

import '../../inventory/viewmodel/product_model.dart';
import '../../other/view/bar_view.dart';
import '../../product_details/view/product_details_view.dart';
import '../../shared/enumLabel/label_names_enum.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LabelNames.INVENTORY_VIEW_APPBAR_TITLES[_currentIndex]),
      ),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_rounded),
              label: LabelNames.BOTTOM_NAVBAR_ITEM_1),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: LabelNames.BOTTOM_NAVBAR_ITEM_2),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_rounded),
              label: LabelNames.BOTTOM_NAVBAR_ITEM_3),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: LabelNames.BOTTOM_NAVBAR_ITEM_4),
        ],
        onTap: onTabTapped,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orangeAccent,
        iconSize: 32.0,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Product? _product;
  Widget body() {
    switch (_currentIndex) {
      case 0:
        return InventoryView(
          gotoProductPage: (product) {
            _product = product;
            setState(() {
              _currentIndex = 2;
            });
          },
        );
      case 1:
        return SalesMode(
          gotoProductPage: (product) {
            _product = product;
            setState(() {
              _currentIndex = 2;
            });
          },
        );
      case 2:
        return ProductView(
          product: _product,
        );
      case 3:
        return const Bar();
    }
    return const Bar();
  }

  // final List<Widget> _children = const [
  //   InventoryView(),
  //   SalesMode(),
  //   ProductView(),
  //   Bar(),
  // ];
}
