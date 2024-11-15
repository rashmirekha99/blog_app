import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:flutter/material.dart';


class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppPalette.borderColor),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9), topRight: Radius.circular(9)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color:
                              AppPalette.textBlackColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        blog.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppPalette.white),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blog.topics
                          .map((topic) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(label: Text(topic)),
                              ))
                          .toList(),
                    ),
                  )
                ],
              )
            ],
          ),

          //description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blog.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
