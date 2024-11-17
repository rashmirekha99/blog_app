import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlogPage extends StatefulWidget {
  const MyBlogPage({super.key});

  @override
  State<MyBlogPage> createState() => _MyBlogPageState();
}

class _MyBlogPageState extends State<MyBlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogReadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Constant.navBarMyBlogText),
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
            final userId =
                (context.read<UserCubitCubit>().state as AppUserState).user.id;
            if (state is BlogLoading) {
              return const Loader();
            } else if (state is BlogListSucess) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];

                    if (blog.posterId == userId) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/single_blog_page',
                                arguments: blog,
                              );
                              
                            },
                            child: BlogCard(blog: blog)),
                      );
                    }
                    return const SizedBox();
                  });
            }
            return const SizedBox();
          },
        ));
  }
}
