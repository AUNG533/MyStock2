// management_page.dart
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/models/product.dart';
import 'package:my_stock/src/pages/management/product_image.dart';
import 'package:my_stock/src/service/network_service.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late bool _isEdit; // Check if the user is editing the product
  Product? _product; // The product that the user is editing
  final _formKey = GlobalKey<FormState>(); // The form key
  File? _imageFile; // The image file

  // Initialize the state
  @override
  initState() {
    _isEdit = false;
    _product = Product(image: '', id: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Arguments Edit Product
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Product) {
      _isEdit = true;
      _product = arguments;
    }
    return Scaffold(
      appBar: _buildAppBar(), // App Bar Method
      body: SingleChildScrollView(
          child: Form(
        key: _formKey, // The form key
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildNameInput(), // ช่องกรอกชื่อสินค้า
              const SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    child: _buildPriceInput(),
                  ), // ช่องกรอกราคาสินค้า
                  const SizedBox(width: 12),
                  Flexible(
                    child: _buildStockInput(),
                  ), // ช่องกรอกจำนวนสินค้า
                ],
              ),
              ProductImage(
                callBack, // ฟังก์ชั่นสำหรับรูปภาพ
                _product!.image, // รูปภาพสินค้า
              ), // ช่องใส่รูปภาพสินค้า
              const SizedBox(height: 80), // ช่องว่างสูง 80px
            ],
          ),
        ),
      )),
    );
  }

  callBack(File imageFile) {
    _imageFile = imageFile; // Set the image file
  }

  // Build the App Bar
  AppBar _buildAppBar() {
    return AppBar(
      // Create a App Bar // Set the title of the app bar
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        // ถ้ากำลังแก้ไขสินค้า ให้มีปุ่มลบสินค้า
        if (_isEdit) _buildDeleteButton(),
        // Submit Button
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            _formKey.currentState!.save(); // Save the data
            FocusScope.of(context)
                .requestFocus(FocusNode()); // Unfocused the keyboard
            if (_isEdit) {
              editProduct(); // Edit the product
            } else {
              addProduct(); // Add the product
            }
          },
          child: const Text('submit'),
        )
      ],
    );
  }

  // Style the InputDecorator (สำหรับการกรอกชื่อสินค้า)
  InputDecoration inputStyle(label) => InputDecoration(
        // กรอบของอินพุตที่เลือก
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        // กรอบของอินพุตที่ปกติ
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 2),
        ),
        labelText: label, // ชื่อฟิวล์
      );

  // TextFormField for the name of the product
  TextFormField _buildNameInput() => TextFormField(
        initialValue: _product!.name, // ชื่อสินค้าที่กำลังแก้ไข
        decoration: inputStyle('Name'),
        // Save the data
        onSaved: (String? value) {
          _product!.name = value!.isEmpty ? '-' : value;
        },
      );

  // TextFormField for the price of the product
  TextFormField _buildPriceInput() => TextFormField(
        initialValue: _product!.price?.toString(), // ราคาสินค้าที่กำลังแก้ไข
        decoration: inputStyle('Price'),
        keyboardType: TextInputType.number, // รูบแบบแป้นพิมพ์ตัวเลข
        // Save the data, type int
        onSaved: (String? value) {
          _product!.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  // TextFormField for the stock of the product
  TextFormField _buildStockInput() => TextFormField(
        initialValue: _product!.stock?.toString(), // จำนวนสินค้าที่กำลังแก้ไข
        decoration: inputStyle('Stock'),
        keyboardType: TextInputType.number, // รูบแบบแป้นพิมพ์ตัวเลข
        // Save the data, type int
        onSaved: (String? value) {
          _product!.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  // Add the product to the database
  void addProduct() {
    NetworkService()
        .addProduct(_product!, imageFile: _imageFile)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result); // Show the result
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  // Create and Show a alert bar
  void showAlertBar(
    String message, {
    IconData icon = FontAwesomeIcons.checkCircle,
    Color color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: FaIcon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context); // Show the alert bar
  }

  // Button Delete the product from the database
  _buildDeleteButton() => IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Delete Product'),
                content:
                    const Text('Are you sure want to delete this product?'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('cancel'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                  FlatButton(
                    child:
                        const Text('ok', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                      _deleteProduct(); // Delete the product
                    },
                  ),
                ],
              );
            },
          );
        },
      );

  // Delete the product from the database
  void _deleteProduct() {
    NetworkService().deleteProduct(_product!.id).then((result) {
      Navigator.pop(context);
      showAlertBar(result); // Show the result
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  // Edit the product in the database
  void editProduct() {
    NetworkService()
        .editProduct(_product!, imageFile: _imageFile)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result); // Show the result
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }
}
