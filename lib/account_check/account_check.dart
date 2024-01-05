import 'package:flutter/material.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  // Constructor của widget AccountCheck, nhận vào hai tham số: login và press.
  const AccountCheck({
    required this.login, // Biến login xác định trạng thái đăng nhập hay chưa đăng nhập.
    required this.press, // Hàm press sẽ được gọi khi người dùng nhấn vào "Create Account" hoặc "Login".
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // Hiển thị văn bản tùy thuộc vào trạng thái đăng nhập.
          login ? "Don't have an Account" : "Already have an Account ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(width: 20,), // Khoảng cách giữa các phần tử trong hàng
        GestureDetector(
          onTap: press, // Gọi hàm press khi người dùng nhấn vào "Create Account" hoặc "Login".
          child: Text(
            // Hiển thị văn bản tùy thuộc vào trạng thái đăng nhập.
            login ? "Create Account" : "Login",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
