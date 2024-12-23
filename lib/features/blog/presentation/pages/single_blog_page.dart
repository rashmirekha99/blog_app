import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/show_dialog_box.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleBlog extends StatelessWidget {
  const SingleBlog({super.key, required this.blog, this.isMyBlog = false});
  final Blog blog;
  final bool isMyBlog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
              visible: isMyBlog,
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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.messsage);
          } else if (state is BlogDeleteSucess) {
            showSnackBar(context, state.message);
            Navigator.pushNamedAndRemoveUntil(context,
                RouteNames.initialRouteName, (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return Scrollbar(
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('By ${blog.posterName ?? ''}'),
                                Row(
                                  children: [
                                    Text(
                                      blog.updatedAt.toString().split(' ')[0],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      '    ${calculateReadingTime(blog.content)} ${Constant.minutesText} ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //delete
                            Visibility(
                              visible: isMyBlog,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {
                                    showDialogBox(
                                        context,
                                        () => context.read<BlogBloc>().add(
                                            BlogDeleteEvent(blogId: blog.id)));
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Hero(
                      tag: blog.id,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: blog.imageUrl,
                        placeholder: (context, url) => const Loader(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
