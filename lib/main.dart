import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.value(_auth.currentUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final bool isLoggedIn = snapshot.hasData;
            // Kiểm tra đăng nhập và điều hướng đến trang HomePage hoặc LoginPage
            return isLoggedIn ? HomePage() : LoginPage();
          }

          // Hiển thị tiến trình đang tải khi đang kiểm tra đăng nhập
          return CircularProgressIndicator();
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home':(context) => HomePage(),
        // Thêm các routes khác của bạn ở đây nếu cần
      },
    );
  }
}
