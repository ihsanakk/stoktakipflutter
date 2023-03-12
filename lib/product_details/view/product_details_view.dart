import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/product_details/model/message_response.dart';
import 'package:stoktakip/product_details/model/unauthorized_response.dart';
import 'package:stoktakip/product_details/service/product_details_service.dart';
import 'package:stoktakip/shared/configuration/dio_options.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../inventory/viewmodel/product_model.dart';
import '../model/product_model.dart';

class ProductView extends StatefulWidget {
  final Product? product;
  final void Function() gotoInventoryPage;
  const ProductView({Key? key, this.product, required this.gotoInventoryPage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductView();
}

class _ProductView extends State<ProductView> with CacheManager {
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
                onPressed: () {
                  scanProductBarcode();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: Text(LabelNames.PRODUCT_VIEW_SCAN)),
          )
        ],
      ),
    );
  }

  deleteFromCache(String barcode) async {
    final productList = await getProductsFromCache();
    productList!.removeWhere((element) => element.productBarcode == barcode);
    saveProductsToCache(productList);
  }

  saveToCache(ProductModel productModel) async {
    final productList = await getProductsFromCache();
    productList!.add(Product(
        productBarcode: productModel.productBarcode,
        productName: productModel.productName,
        productPrice: productModel.productPrice,
        numOfProducts: productModel.numOfProducts));
    saveProductsToCache(productList);
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
        saveToCache(productModel);
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
    if (_productBarcodeController!.text.isNotEmpty) {
      final response = await productDetailsService
          .deleteProductByBarcode(productModel.productBarcode ?? '');
      if (response != null) {
        if (response is MessageResponse) {
          if (response.message!.toLowerCase().contains("not found")) {
            showMessage(LabelNames.PRODUCT_DETAILS_MESSAGE_NOT_FOUND);
          }
        } else if (response is ProductModel) {
          showMessage(LabelNames.PRODUCT_DETAILS_MESSAGE_PRODUCT_DELETED);
          deleteFromCache(productModel.productBarcode ?? '');
          clearForm();
          widget.gotoInventoryPage();
        }
      } else {
        showMessage(LabelNames.SERVICE_ERROR);
      }
      clearForm();
    } else {
      showMessage("!!!");
    }
  }

  void scanProductBarcode() async {
    clearForm();
    String result = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);

    final response = await productDetailsService.getproductByBarcode(result);
    if (response != null) {
      if (response is ProductModel) {
        _productBarcodeController!.text = response.productBarcode ?? "";
        _productNameController!.text = response.productName ?? "";
        _numOfProductController!.text = (response.numOfProducts ?? 0) as String;
        _productPriceController!.text =
            (response.productPrice ?? 0.0) as String;
      } else if (response is UnauthorizedResponse) {
        showMessage(LabelNames.UNAUTHORIZED_REQUEST);
      } else if (response is MessageResponse) {
        clearForm();
        showMessage(LabelNames.PRODUCT_DETAILS_MESSAGE_NOT_FOUND);
        _productBarcodeController!.text = result;
      }
    }
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
