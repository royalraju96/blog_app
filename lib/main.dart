import 'package:blog_app/authentication.dart';
//import 'package:blog_app/loginRegisterPage.dart';
import 'package:blog_app/mapping.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blog App",
      theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7)),
      home: MappingPage(
        auth: Auth(),
      ),
    );
  }
}
