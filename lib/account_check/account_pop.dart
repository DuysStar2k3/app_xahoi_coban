import 'package:flutter/material.dart';

class AccountPop extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  // Constructor của widget AccountPop, nhận vào hai tham số: login và press.
  const AccountPop({required this.login, required this.press});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // Hiển thị văn bản tùy thuộc vào trạng thái đăng nhập.
          login ? "I Already have an Account" : "I have an Account",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(
          width: 20,
        ),
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
