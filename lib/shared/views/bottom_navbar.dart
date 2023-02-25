import 'package:flutter/material.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.orangeAccent,
      iconSize: 32.0,
    );
  }
}
