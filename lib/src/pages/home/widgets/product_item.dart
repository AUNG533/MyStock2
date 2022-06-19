// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  // อัตาราส่วน LayoutBuilder - constraints.maxHeight / ส่งค่ามาจากฟังก์ชันของคลาส Stock
  final double maxHeight; // 100 % childAspectRatio/อัตราส่วน item

  const ProductItem(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildImage(), // แสดงรูปภาพ
          _buildInfo(), // แสดงข้อมูลสินค้า
        ],
      ),
    );
  }

  Image _buildImage() {
    final height = maxHeight * 0.7; // ความสูงของรูปภาพ
    const productImage =
        'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png';
    return Image.network(
      productImage,
      height: height,
    );
  }

  Expanded _buildInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // จัดตำแหน่งข้อมูล ให้อยู่สุด 2 ด้าน
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text('\$11111'), // ราคาสินค้า
                  Text('33333'), // จำนวนสินค้า
                ],
              )
            ],
          ),
        ),
      );
}
