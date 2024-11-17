import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogTopicRow extends StatefulWidget {
  const BlogTopicRow({super.key, required this.selectedTopics});
  final List<String> selectedTopics;

  @override
  State<BlogTopicRow> createState() => _BlogTopicRowState();
}

class _BlogTopicRowState extends State<BlogTopicRow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Constant.topics
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selectedTopics.contains(e)) {
                        widget.selectedTopics.remove(e);
                      } else {
                        widget.selectedTopics.add(e);
                      }

                      setState(() {});
                    },
                    child: Chip(
                      label: Text(e),
                      color: widget.selectedTopics.contains(e)
                          ? const WidgetStatePropertyAll(AppPalette.gradient2)
                          : null,
                      side: const BorderSide(color: AppPalette.borderColor),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
