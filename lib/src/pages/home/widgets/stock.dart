// stock.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/models/product.dart';
import 'package:my_stock/src/pages/home/widgets/product_item.dart';
import 'package:my_stock/src/service/network_service.dart';

// convert StatelessWidget to StatefulWidget
class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    // Create a future to get the products
    return FutureBuilder<List<Product>>(
      future: NetworkService().getAllProduct(0), // Get the All Product
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>? product = snapshot.data; // Get the posts
          // Check if the product is null
          if (product == null || product.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 22),
              child: const Text('No data'),
            );
          }
          // the product is not null
          return RefreshIndicator(
            // Create a refresh indicator
            onRefresh: () async {
              setState(() {});
            },
            child: _buildProductGridView(product), // Return the Product Grid View
          );
        }
        // If the posts is error
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 22),
            child: Text('${snapshot.error}'),
          ); // Return the error
        }
        // If the posts is loading or not loaded
        return const Center(
            child:
                CircularProgressIndicator()); // Return the progress indicator
      },
    );
  }

  // Create a method to build the Product Grid View
  GridView _buildProductGridView(List<Product> product) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 50),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // จำนวน column ที่จะแสดง
        childAspectRatio: 0.5, // อัตราส่วน item
        crossAxisSpacing: 4, // ระยะห่างระหว่าง item
        mainAxisSpacing: 4, // ระยะห่างระหว่าง item
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return ProductItem(constraints.maxHeight, product: product[index]);
        },
      ),
      itemCount: product.length, // จำนวน item ตาม product
    );
  }
}
