// management_page.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/models/product.dart';
import 'package:my_stock/src/pages/management/product_image.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  bool? _isEdit; // Check if the user is editing the product
  Product? _product; // The product that the user is editing
  final _formKey = GlobalKey<FormState>(); // The form key

  // Initialize the state
  @override
  initState() {
    _isEdit = false;
    _product = Product();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // App Bar Method
      body: Form(
        key: _formKey, // The form key
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildNameInput(), // ช่องกรอกชื่อสินค้า
              const SizedBox(height: 12),
              Row(
                children: [
                  //
                  Flexible(child: _buildPriceInput()), // ช่องกรอกราคาสินค้า
                  const SizedBox(width: 12),
                  Flexible(child: _buildStockInput()), // ช่องกรอกจำนวนสินค้า
                ],
              ),
              const ProductImage() // ช่องใส่รูปภาพสินค้า
            ],
          ),
        ),
      ),
    );
  }

  // Build the App Bar
  AppBar _buildAppBar() {
    return AppBar(
      // Create a App Bar // Set the title of the app bar
      title: Text(_isEdit! ? 'Edit Product' : 'Create Product'),
      actions: [
        // Submit Button
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            _formKey.currentState!.save(); // Save the data
            print(_product!.name);
            print(_product!.price.toString());
            print(_product!.stock.toString());
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
        decoration: inputStyle('Name'),
        // Save the data
        onSaved: (String? value) {
          _product!.name = value!.isEmpty ? '-' : value;
        },
      );

  // TextFormField for the price of the product
  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('Price'),
        keyboardType: TextInputType.number, // รูบแบบแป้นพิมพ์ตัวเลข
        // Save the data type int
        onSaved: (String? value) {
          _product!.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  // TextFormField for the stock of the product
  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('Stock'),
        keyboardType: TextInputType.number, // รูบแบบแป้นพิมพ์ตัวเลข
        // Save the data type int
        onSaved: (String? value) {
          _product!.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );
}
