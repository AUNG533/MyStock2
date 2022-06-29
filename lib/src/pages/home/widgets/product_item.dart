// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// product_item.dart

import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/api.dart';
import 'package:my_stock/src/models/product.dart';
import 'package:my_stock/src/utils/format.dart';
import 'package:my_stock/src/widgets/image_not_found.dart';

class ProductItem extends StatelessWidget {
  // อัตาราส่วน LayoutBuilder - constraints.maxHeight / ส่งค่ามาจากฟังก์ชันของคลาส Stock
  final double maxHeight; // 100 % childAspectRatio/อัตราส่วน item
  final Product product; // ดึ่วค่า Class Product
  final VoidCallback? onTap; // คลาสที่จะทำงานหลังจากกดปุ่มของสินค้า

  const ProductItem(this.maxHeight,
      {Key? key, required this.product, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // รับค่า onTap มาจาก stock.dart/_buildProductGridView/LayoutBuilder/ProductItem
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildImage(), // แสดงรูปภาพ
            _buildInfo(), // แสดงข้อมูลสินค้า
          ],
        ),
      ),
    );
  }

  Stack _buildImage() {
    final height = maxHeight * 0.7; // ความสูงของรูปภาพ
    final productImage = product.image; // รับค่ารูปภาพจาก Class Product
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: productImage != null && productImage.isNotEmpty // ถ้ามีรูปภาพ
              ? Image.network(
                  '${API.imageURL}/$productImage') // แสดงรูปภาพจาก server
              : ImageNotFound(), // ถ้าไม่มีรูปภาพ แสดงสิ่งนี้
        ),
        // Check if the stock is 0 Show the OutOfStock
        if (product.stock! <= 0) _buildOutOfStock(), // ถ้าสินค้าหมด
      ],
    );
  }

  Expanded _buildInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // จัดตำแหน่งข้อมูล ให้อยู่สุด 2 ด้าน
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ชื่อสินค้า
              Text(
                product.name!,
                maxLines: 2,
                overflow: TextOverflow
                    .ellipsis, // ตัดคำออกจากตัวอักษรที่เกิน / แสดง ...
              ),
              Row(
                // จัดตำแหน่งข้อมูล ให้อยู่สุด 2 ด้าน
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ราคาสินค้า
                  Text(
                    '฿${formatCurrency.format(product.price!)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // จำนวนสินค้า
                  Text(
                    '${formatNumber.format(product.stock!)} pieces',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ), // จำนวนสินค้า
                ],
              ),
            ],
          ),
        ),
      );

  Positioned _buildOutOfStock() => Positioned(
        top: 2,
        right: 2,
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'Out of Stock',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      );
}
