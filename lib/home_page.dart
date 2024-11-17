import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/pages/index_pages/home_index_page.dart';
import 'package:blog_app/core/pages/index_pages/my_blog_index_page.dart';
import 'package:blog_app/core/pages/index_pages/setting_index_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeIndexPage(),
          MyBlogIndexPage(),
          SettingIndexPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
         
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: Constant.navBarHomeText,
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: Constant.navBarMyBlogText,
              icon: Icon(Icons.article),
            ),
            BottomNavigationBarItem(
              label: Constant.navBarSettingText,
              icon: Icon(Icons.settings),
            ),
          ]),
    );
  }
}
