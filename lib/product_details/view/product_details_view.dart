import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/inventory/viewmodel/product_model.dart';
import 'package:stoktakip/product_details/model/message_response.dart';
import 'package:stoktakip/product_details/model/product_model.dart';
import 'package:stoktakip/product_details/service/product_details_service.dart';
import 'package:stoktakip/shared/configuration/dio_options.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

class ProductView extends StatefulWidget {
  final Product? product;
  final void Function() gotoInventoryPage;
  const ProductView({Key? key, this.product, required this.gotoInventoryPage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  Product productPlaceholder = Product(
      imageUrl: '',
      numOfProducts: 0,
      productBarcode: '',
      productCategory: '',
      productName: '',
      productPrice: 0.0);
  ProductModel productModel = ProductModel(
      productBarcode: '',
      numOfProducts: 0,
      productCategory: '',
      productName: '',
      productPrice: 0.0);

  late final ProductDetailsService productDetailsService;

  @override
  void initState() {
    super.initState();
    productDetailsService = ProductDetailsService(CustomDio.getDio());

    _productNameController = TextEditingController(
        text: ((widget.product) ?? productPlaceholder).productName);
    _productBarcodeController = TextEditingController(
        text: ((widget.product) ?? productPlaceholder).productBarcode);
    _productPriceController = TextEditingController(
      text: '${((widget.product) ?? productPlaceholder).productPrice ?? '0.0'}',
    );
    _numOfProductController = TextEditingController(
        text:
            '${((widget.product) ?? productPlaceholder).numOfProducts ?? '0'}');
  }

  TextEditingController? _productNameController;
  TextEditingController? _productBarcodeController;
  TextEditingController? _productPriceController;
  TextEditingController? _numOfProductController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                          decoration: InputDecoration(
                            labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_NAME,
                          ),
                          onSaved: (newValue) {
                            productModel.productName = newValue;
                          },
                          controller: _productNameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return LabelNames
                                  .PRODUCT_DETAILS_MESSAGE_INVALID_PRODUCT_BARCODE;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText:
                                LabelNames.PRODUCT_DETAILS_PRODUCT_BARCODE,
                          ),
                          onSaved: (newValue) {
                            productModel.productBarcode = newValue;
                          },
                          controller: _productBarcodeController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return LabelNames
                                  .PRODUCT_DETAILS_MESSAGE_INVALID_PRODUCT_BARCODE;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_PRICE,
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) {
                            productModel.productPrice =
                                double.tryParse(newValue ?? '0.0');
                          },
                          controller: _productPriceController,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText:
                                LabelNames.PRODUCT_DETAILS_PRODUCT_QUANTITY,
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) {
                            productModel.numOfProducts =
                                int.tryParse(newValue ?? '0');
                          },
                          controller: _numOfProductController,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_CREATED_AT,
                  //   ),
                  //   initialValue:
                  //       ((widget.product) ?? productPlaceholder).productName,
                  // ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     labelText: LabelNames.PRODUCT_DETAILS_PRODUCT_DESCRIPTION,
                  //   ),
                  //   initialValue:
                  //       ((widget.product) ?? productPlaceholder).productName,
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  deleteProduct();
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
                  saveProduct();
                },
                icon: const Icon(
                  Icons.file_upload_rounded,
                  size: 36,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: Text(LabelNames.PRODUCT_VIEW_SCAN)),
          )
        ],
      ),
    );
  }

  void showMessage(String? message) {
    if (message != '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void saveProduct() async {
    final FormState? form = _formKey.currentState;
    form!.save();

    if (form.validate()) {
      final response = await productDetailsService.saveProduct(productModel);
      if (response != null) {
        showMessage(LabelNames.PRODUCT_DETAILS_MESSAGE_PRODUCT_SAVED);
        widget.gotoInventoryPage();
      } else {
        showMessage(LabelNames.SERVICE_ERROR);
      }
    } else {
      showMessage(LabelNames.LOGIN_VIEW_MESSAGE_INVALID_FORM);
    }
  }

  void deleteProduct() async {
    final FormState? form = _formKey.currentState;
    form!.save();

    final response = await productDetailsService
        .deleteProductByBarcode(productModel.productBarcode ?? '');
    if (response != null) {
      if (response is MessageResponse) {
        showMessage(response.message);
      } else if (response is ProductModel) {
        showMessage(LabelNames.PRODUCT_DETAILS_MESSAGE_PRODUCT_DELETED);
        clearForm();
        widget.gotoInventoryPage();
      }
    } else {
      showMessage(LabelNames.SERVICE_ERROR);
    }
    clearForm();
  }

  void scanProductBarcode() async {
    String result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);

    setState(() {});
  }

  void clearForm() {
    _productNameController!.text = '';
    _productBarcodeController!.text = '';
    _productPriceController!.text = '0.0';
    _numOfProductController!.text = '0';

    ((widget.product) ?? productPlaceholder).productName = '';
    ((widget.product) ?? productPlaceholder).productBarcode = '';
    ((widget.product) ?? productPlaceholder).numOfProducts = 0;
    ((widget.product) ?? productPlaceholder).productPrice = 0.0;
  }
}
