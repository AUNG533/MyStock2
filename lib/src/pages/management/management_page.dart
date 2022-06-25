import 'package:flutter/material.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  bool? _isEdit; // Check if the user is editing the product

  // Initialize the state
  @override
  initState() {
    _isEdit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Create a App Bar // Set the title of the app bar
        title: Text(_isEdit! ? 'Edit Product' : 'Create Product'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
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
          ]),
        ),
      ),
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
      );

  // TextFormField for the price of the product
  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('Price'),
      );

  // TextFormField for the stock of the product
  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('Stock'),
      );
}
