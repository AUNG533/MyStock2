// stock.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/home/widgets/product_item.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // จำนวน column ที่จะแสดง
        childAspectRatio: 0.5, // อัตราส่วน item
        crossAxisSpacing: 5, // ระยะห่างระหว่าง item
        mainAxisSpacing: 5, // ระยะห่างระหว่าง item
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: 5,
    );
  }
}
