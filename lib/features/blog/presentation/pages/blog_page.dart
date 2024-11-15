import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    // final userId =
    //     (context.read<UserCubitCubit>().state as AppUserState).user.id;
    context.read<BlogBloc>().add(BlogReadEvent());
    super.initState();
  }

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
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.messsage);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            } else if (state is BlogListSucess) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.blogs.length,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return Container(
                      // padding: const EdgeInsets.all(10),
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
                                  child: Image.network(
                                    state.blogs[index].imageUrl,
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
                                          color: AppPalette.textBlackColor
                                              .withValues(alpha: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Chip(label: Text(topic)),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                          //descriptipm
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
                  });
            }
            return const SizedBox();
          },
        ));
  }
}
