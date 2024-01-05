import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    Size size = MediaQuery.of(context).size;

    return Padding(
      // Khoảng cách giữa phần nội dung và các mép của màn hình
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Column(
        children: [
          SizedBox(
            // Kích thước của hộp trống để tạo khoảng cách từ đỉnh màn hình
            height: size.height * 0.05,
          ),
          Center(
            child: Text(
              "Photo-Share",
              style: TextStyle(
                fontSize: 75,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Signatra",
              ),
            ),
          ),
          SizedBox(
            // Kích thước của hộp trống giữa các dòng văn bản
            height: 20,
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white60,
                fontWeight: FontWeight.bold,
                fontFamily: "Bebas",
              ),
            ),
          )
        ],
      ),
    );
  }
}
