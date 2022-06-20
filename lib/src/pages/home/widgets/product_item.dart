// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// product_item.dart

import 'package:flutter/material.dart';
import 'package:my_stock/src/utils/format.dart';
import 'package:my_stock/src/widgets/image_not_found.dart';

class ProductItem extends StatelessWidget {
  // อัตาราส่วน LayoutBuilder - constraints.maxHeight / ส่งค่ามาจากฟังก์ชันของคลาส Stock
  final double maxHeight; // 100 % childAspectRatio/อัตราส่วน item

  const ProductItem(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('ProductItem');
      },
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
    final stock = 10; // จำลอง จำนวนสินค้า แต่ละรายการ
    const productImage =
        'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png';
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: productImage != null && productImage.isNotEmpty // ถ้ามีรูปภาพ
              ? Image.network(productImage) // แสดงรูปภาพ
              : ImageNotFound(), // ถ้าไม่มีรูปภาพ
        ),
        if (stock <= 0) _buildOutOfStock(), // ถ้าสินค้าหมด
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
              Text(
                'Contrary to popular belief, Lorem Ipsum is not simply random text.',
                maxLines: 2,
                overflow: TextOverflow
                    .ellipsis, // ตัดคำออกจากตัวอักษรที่เกิน / แสดง ...
              ),
              Row(
                // จัดตำแหน่งข้อมูล ให้อยู่สุด 2 ด้าน
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '฿${formatCurrency.format(111)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ), // ราคาสินค้า
                  Text(
                    '${formatNumber.format(999)} pieces',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ), // จำนวนสินค้า
                ],
              )
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
