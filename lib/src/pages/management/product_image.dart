// lib/src/pages/management/product_image.dart
// ignore_for_file: prefer_function_declarations_over_variables

// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile; // for the image file
  final _picker = ImagePicker(); // for the image picker

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
          _modalPickImage(); // เปิดหน้าต่างสำหรับเลือกรูปภาพ
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
        container(Image.file(_imageFile!)), // รูปภาพที่แสดงผล
        _buildDeleteImageButton(), // ปุ่มลบรูปภาพ
      ],
    );
  }

  // Clear the image file
  Positioned _buildDeleteImageButton() => Positioned(
        right: 0, // ให้อยู่มุมขวาบน
        child: IconButton(
          onPressed: () {
            setState(() {
              _imageFile = null; // ลบรูปภาพ
            });
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black54,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      );

  void _modalPickImage() {
    // เปิดหน้าต่างสำหรับเลือกรูปภาพ
    final buildListTile =
        (String title, IconData icon, ImageSource imageSource) => ListTile(
              leading: Icon(icon),
              title: Text(title),
              onTap: () async {
                Navigator.pop(context); // Close the modal
                _pickImage(imageSource); // Pick the image
              },
            );

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // เลือกรูปภาพจากกล้อง
          buildListTile(
            'Take a picture from camera',
            Icons.camera_alt,
            ImageSource.camera,
          ),
          // เลือกรูปภาพจากคลังรูปภาพ
          buildListTile(
            'Choose from photo library',
            Icons.photo_library,
            ImageSource.gallery,
          ),
        ],
      ),
    );
  }

  // Pick the image
  void _pickImage(ImageSource imageSource) {
    _picker
        .getImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    )
        .then((file) {
      if (file != null) {
        _cropImage(file.path); // Crop the image
      }
    });
  }

  // Crop the image
  void _cropImage(String file) {
    ImageCropper().cropImage(
      sourcePath: file,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    ).then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path); // Set the image file
        });
      }
    });
  }
}

// วิธีใช้ image_picker อีกรูปแบบหนึ่ง
//
//   void _modalPickImage() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SizedBox(
//         height: 200,
//         child: Column(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_camera),
//               title: const Text('Take a photo'),
//               onTap: () async {
//                 final pickedFile = await _picker.getImage(
//                   source: ImageSource.camera,
//                   imageQuality: 50,
//                 );
//                 setState(() {
//                   _imageFile = File(pickedFile!.path);
//                 });
//                 if (!mounted) return;
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Choose from gallery'),
//               onTap: () async {
//                 final pickedFile = await _picker.getImage(
//                   source: ImageSource.gallery,
//                   imageQuality: 50,
//                 );
//                 setState(() {
//                   _imageFile = File(pickedFile!.path);
//                 });
//                 if (!mounted) return;
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
