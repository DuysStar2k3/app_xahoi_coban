import 'dart:io';

import 'package:flutter/material.dart';

class InFor extends StatelessWidget {
  File? imageFile;

  InFor({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Xử lý khi hình ảnh được chọn
            },
            child: CircleAvatar(
              backgroundImage: imageFile == null
                  ? AssetImage("images/avatar.png")
                  : Image.file(imageFile!).image,
              radius: 50, // Đặt bán kính của CircleAvatar tại đây
            ),
          ),
        ],
      ),
    );
  }
}
