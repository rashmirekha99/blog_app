import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/pages/not_found_page.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_form_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/single_blog_page.dart';

import 'package:flutter/material.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({super.key});

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteNames.initialRouteName:
            return MaterialPageRoute(builder: (context) => const BlogPage());
          case RouteNames.addNewBlogRouteName:
            return MaterialPageRoute(builder: (context) => const AddNewBlog());
          case RouteNames.singleBlogRouteName:
            return MaterialPageRoute(
              builder: (context) => SingleBlog(
                blog: settings.arguments as Blog,
              ),
            );
          default:
            return MaterialPageRoute(
                builder: (context) => const NotFoundPage());
        }
      },
    );
  }
}
