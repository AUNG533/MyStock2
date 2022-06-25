import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile; // for the image file

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickerImage(), // ช่องกรอกรูปภาพ
          _buildPreviewImage(), // รูปภาพที่แสดงผล
        ],
      ),
    );
  }

  // Build the image picker
  _buildPickerImage() => OutlinedButton.icon(
        onPressed: () {
          // todo
        },
        label: const Text('Image'),
        icon: const FaIcon(
          FontAwesomeIcons.image,
        ),
      );

  dynamic _buildPreviewImage() {
    // ignore: prefer_function_declarations_over_variables
    final container = (Widget child) => Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          height: 400,
          child: child,
        );

    // Check image file
    if (_imageFile == null) {
      return const SizedBox();
    }
    return Stack(
      children: [
        container(Image.file(_imageFile!)),
        _buildDeleteImageButton(), // ปุ่มลบรูปภาพ
      ],
    );
  }
  // Clear the image file
  Positioned _buildDeleteImageButton() => Positioned(
        right: 0,
        child: IconButton(
          onPressed: () {
            // todo
          },
          icon: const Icon(Icons.clear),
        ),
      );
}
