import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_new_blog');
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
    );
  }
}
