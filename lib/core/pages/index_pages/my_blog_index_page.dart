import 'package:blog_app/core/pages/not_found_page.dart';
import 'package:blog_app/features/blog/presentation/pages/my_blog_page.dart';
import 'package:flutter/material.dart';

class MyBlogIndexPage extends StatefulWidget {
  const MyBlogIndexPage({super.key});

  @override
  State<MyBlogIndexPage> createState() => _MyBlogIndexPageState();
}

class _MyBlogIndexPageState extends State<MyBlogIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) =>const MyBlogPage());
          default:
            return MaterialPageRoute(
                builder: (context) => const NotFoundPage());
        }
      },
    );
  }
}
