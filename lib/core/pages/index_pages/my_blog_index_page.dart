import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/pages/not_found_page.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blogs_page.dart';
import 'package:blog_app/features/blog/presentation/pages/my_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/single_blog_page.dart';

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
          case RouteNames.initialRouteName:
            return MaterialPageRoute(builder: (context) => const MyBlogPage());
          case RouteNames.singleBlogRouteName:
            return MaterialPageRoute(
              builder: (context) => SingleBlog(
                blog: settings.arguments as Blog,
                isEditIconRequired: true,
              ),
            );
          case RouteNames.addNewBlogRouteName:
            return MaterialPageRoute(
                builder: (context) => AddNewBlog(
                      blog: settings.arguments,
                    ));

          default:
            return MaterialPageRoute(
                builder: (context) => const NotFoundPage());
        }
      },
    );
  }
}
