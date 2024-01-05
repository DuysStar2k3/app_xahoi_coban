import 'package:dev_upload_image/Login_In/component/heading.dart';
import 'package:dev_upload_image/Login_In/component/infor.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // Constructor của LoginScreen
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Ngăn chặn việc thoát khỏi màn hình bằng cách nhấn nút Back
        return false;
      },
      child: Container(
        // Tạo hình nền gradient từ màu hồng đến màu cam đậm
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.deepOrange.shade300,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.2, 0.9],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent, // Đặt màu nền của Scaffold là trong suốt
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hiển thị tiêu đề của trang đăng nhập
                  HeadText(),
                  // Hiển thị thông tin đăng nhập (các trường nhập liệu và nút đăng nhập)
                  InFor(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
