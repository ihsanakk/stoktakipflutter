import 'package:flutter/material.dart';

import '../../inventory/viewmodel/product_model.dart';

class ProductCardView extends StatefulWidget {
  final Product product;
  final bool? isSaleMode;
  const ProductCardView({super.key, required this.product, this.isSaleMode});

  @override
  State<ProductCardView> createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> {
  @override
  Widget build(BuildContext context) {
    Row addRemoveButtons = Row(
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
    );
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                image: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
          ),
          visualDensity: const VisualDensity(vertical: 3), // to expand
          title: Text(widget.product.productName!.toUpperCase(), maxLines: 2),
          subtitle: const Text("Spec"),
          trailing: Column(
            children: [
              Text(
                widget.product.productName!.toUpperCase(),
              ),
              if (widget.isSaleMode!) addRemoveButtons,
            ],
          ),
        ),
      ),
    );
  }
}
