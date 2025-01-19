import 'package:flutter/material.dart';
import 'Auth/login_screen.dart';
import 'Auth/register_screen.dart';
import 'Admin/admin_home.dart';
import 'User/user_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/adminHome': (context) => AdminHome(),
        '/userHome': (context) => UserHome(),
      },
    );
  }
}
