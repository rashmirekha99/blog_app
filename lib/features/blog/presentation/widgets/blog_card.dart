import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
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
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 200,
                    width: double.infinity,
                    child: Hero(
                      tag: blog.id,
                      child: CachedNetworkImage(
                        useOldImageOnUrlChange: true,
                        cacheKey: blog.imageUrl,
                        fit: BoxFit.fitWidth,
                        imageUrl: blog.imageUrl,
                        placeholder: (context, url) => const Loader(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppPalette.textBlackColor
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          blog.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    //topic row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.topics
                            .map((topic) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(label: Text(topic))))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          style: Theme.of(context).textTheme.headlineSmall,
                          '${calculateReadingTime(blog.content)} ${Constant.minutesText}'),
                    ),
                  ],
                )
              ],
            ),

            //description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                style: Theme.of(context).textTheme.bodyMedium,
                blog.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
