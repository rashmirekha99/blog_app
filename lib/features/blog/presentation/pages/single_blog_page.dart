import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleBlog extends StatelessWidget {
  const SingleBlog(
      {super.key, required this.blog, this.isEditIconRequired = false});
  final Blog blog;
  final bool isEditIconRequired;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
              visible: isEditIconRequired,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.addNewBlogRouteName,
                      arguments: blog,
                    );
                  },
                  icon: const Icon(Icons.edit)))
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.topics
                            .map((topic) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 8, top: 8, bottom: 8),
                                child: Text(topic)))
                            .toList(),
                      ),
                    ),
                    const Text('By Rashmi Rekha'),
                    Row(
                      children: [
                        Text(
                          blog.updatedAt.toString().split(' ')[0],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '    ${calculateReadingTime(blog.content)} ${Constant.minutesText} ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: blog.imageUrl,
                  placeholder: (context, url) => const Loader(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 25),
                child: Text(
                  blog.content,
                  style: const TextStyle(height: 1.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
