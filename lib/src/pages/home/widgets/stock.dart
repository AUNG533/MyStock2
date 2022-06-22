// stock.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/models/post.dart';
import 'package:my_stock/src/pages/home/widgets/product_item.dart';
import 'package:my_stock/src/service/network_service.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    // Create a future to get the posts
    return FutureBuilder<List<Post>>(
      future: NetworkService().fetchPosts(0), // Get the posts
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post>? post = snapshot.data; // Get the posts
          // Check if the posts is null
          if (post == null || post.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 22),
              child: const Text('No data'),
            );
          }
          // the posts is not null
          return RefreshIndicator(
            // Create a refresh indicator
            onRefresh: () async {
              setState(() {});
            },
            child: _buildProductGridView(post), // Return the Product Grid View
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
  GridView _buildProductGridView(List<Post> post) {
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
          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: post.length, // จำนวน item ตาม post
    );
  }
}
