// image_not_found.dart
// สำหรับการแสดงผลเมื่อไม่มีรูปภาพ
import 'package:flutter/material.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.image_not_supported,
          color: Colors.black54,
          size: 50,
        ),
        SizedBox(height: 8),
        Text(
          'Image Not Found',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
